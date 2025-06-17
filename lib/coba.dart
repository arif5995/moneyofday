void main(){
  var nums1 = [0,0,1,1,1,2,2,3,3,4];
  var m = 3;
  var nums2 = [2,5,6];
  var n = 3;
  var elements = ["a", "b", "c", "d", "e", "a", "b", "c", "f", "g", "h", "h", "h", "e"];
  
  // print(merge(nums1, m, nums2, n));

  // print(removeElement(nums1, m));

  // print(removeDuplicate(nums1));

  print(countCharacterFrequencies(elements));
}

List<int> merge(List<int> nums1, int m, List<int> nums2, int n){
  int midx = m-1;
  int nidx = n-1;
  int right = m+n-1;
  
  while (nidx >= 0){
    if (midx >=0 && nums1[midx] > nums2[nidx]){
        print("in 1 ${nums1[midx]}");
        nums1[right] = nums1[midx];
        midx -= 1;
        right -= 1;
    }else{
      nums1[right] = nums2[nidx];
      print("in 2 ${nums2[nidx]}");
      nidx -= 1;
      right -= 1;
    }
    

  }
  return nums1;
}

List<int> removeElement(List<int> nums, int val){

  int k = 0;
  for(var i=0; i<nums.length; i++){
      if(nums[i] != val){
        print("angka ${nums[i]}");
        nums[k] = nums[i];

        k += 1;
      }
  }
  return nums;
}

List<int> removeDuplicate(List<int> nums){
  if (nums.length == 0)
    return [];
  List<int> r = [];
  int i = 1;
  for (var j = 1; j <nums.length; j++){
    print("angka ${nums[j]}");
    print("angka1 ${nums[i-1]}");
      if (nums[j] != nums[i-1]){
        print("angka2 ${nums[i]}");
        nums[i] = nums[j];
        r.add(nums[j]);
        i++;

      }
  }
  return r;
}

Map countCharacterFrequencies(List<String> chars){
  var map = Map();
  for (var char in chars) {
    if (!map.containsKey(char)){
        map[char] = 1;
    }else{
        map[char] +=1;
    }
  }

  return map;
}