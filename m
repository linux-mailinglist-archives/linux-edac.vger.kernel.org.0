Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7A48279E
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jan 2022 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiAAMgn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 1 Jan 2022 07:36:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:45643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbiAAMgn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 1 Jan 2022 07:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641040603; x=1672576603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UFJpSOl6kq/jg+uGFajvjo0TFaEUc6qNNEzPw6RQvOA=;
  b=Lpc1gHhYHB6QMzfb4IuycccXdrHywHx6R1GgkjP3OETf81Q/OQ6Vhknp
   qKxlNR0Q71y5mm+ft4pRY7LUVrG9MhZkKP+ej7pP0jCTpOQ1uJFeF2iP9
   NYlqMTBG8qw4OfThMXU1Ejg6LlukSm3TW/PhjPyVH1JoxUjUHYRHvoaIo
   Sq2ISER/g74fqBUevv/GkbHaZ1CrLAfSah7mQc/GemGcHeGC1KOnmfpki
   6T7vchl9fM1pP68OUTK3snCkEUt6tDvV1h4thf7kyrU/Ap+MzEeIFrZTZ
   oMxKvauVtJwKu4nPbD58fAmfX7UHY1FOGpvv3z4lSBRH0HiJjDPaAbymH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="305250864"
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="305250864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 04:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="687691127"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jan 2022 04:36:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3dcl-000CRY-Di; Sat, 01 Jan 2022 12:36:39 +0000
Date:   Sat, 1 Jan 2022 20:36:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, william.roche@oracle.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 2/2] EDAC/amd64: Add new register offset support and
 related changes
Message-ID: <202201012032.PZLw1uMC-lkp@intel.com>
References: <20211228200615.412999-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228200615.412999-3-yazen.ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Yazen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on next-20211224]
[cannot apply to linux/master linus/master v5.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yazen-Ghannam/AMD-Family-19h-Models-10h-1Fh-Updates/20211229-040749
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: x86_64-randconfig-c007-20211231 (https://download.01.org/0day-ci/archive/20220101/202201012032.PZLw1uMC-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7cd109b92c72855937273a6c8ab19016fbe27d33)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/dfcd741f577d123f8b488cf88979d6bac6dca5da
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yazen-Ghannam/AMD-Family-19h-Models-10h-1Fh-Updates/20211229-040749
        git checkout dfcd741f577d123f8b488cf88979d6bac6dca5da
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/edac/amd64_edac.c:1982:52: warning: variable 'dimm' is uninitialized when used here [-Wuninitialized]
           edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
                                                             ^~~~
   drivers/edac/edac_mc.h:77:32: note: expanded from macro 'edac_dbg'
                               "%s: " fmt, __func__, ##__VA_ARGS__);       \
                                                       ^~~~~~~~~~~
   drivers/edac/edac_mc.h:49:42: note: expanded from macro 'edac_printk'
           printk(level "EDAC " prefix ": " fmt, ##arg)
                                                   ^~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
   drivers/edac/amd64_edac.c:1923:10: note: initialize the variable 'dimm' to silence this warning
           int dimm, size = 0;
                   ^
                    = 0
   1 warning generated.


vim +/dimm +1982 drivers/edac/amd64_edac.c

94c1acf2c85b03 Aravind Gopalakrishnan 2013-04-17  1916  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1917  static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1918  				    unsigned int cs_mode, int csrow_nr)
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1919  {
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1920  	u32 addr_mask_orig, addr_mask_deinterleaved;
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1921  	u32 msb, weight, num_zero_bits;
dfcd741f577d12 Yazen Ghannam          2021-12-28  1922  	int cs_mask_nr = csrow_nr;
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1923  	int dimm, size = 0;
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1924  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1925  	/* No Chip Selects are enabled. */
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1926  	if (!cs_mode)
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1927  		return size;
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1928  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1929  	/* Requested size of an even CS but none are enabled. */
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1930  	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1931  		return size;
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1932  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1933  	/* Requested size of an odd CS but none are enabled. */
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1934  	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1935  		return size;
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1936  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1937  	/*
dfcd741f577d12 Yazen Ghannam          2021-12-28  1938  	 * Family 17h introduced systems with one mask per DIMM,
dfcd741f577d12 Yazen Ghannam          2021-12-28  1939  	 * and two Chip Selects per DIMM.
dfcd741f577d12 Yazen Ghannam          2021-12-28  1940  	 *
dfcd741f577d12 Yazen Ghannam          2021-12-28  1941  	 *	CS0 and CS1 -> MASK0 / DIMM0
dfcd741f577d12 Yazen Ghannam          2021-12-28  1942  	 *	CS2 and CS3 -> MASK1 / DIMM1
dfcd741f577d12 Yazen Ghannam          2021-12-28  1943  	 *
dfcd741f577d12 Yazen Ghannam          2021-12-28  1944  	 * Family 19h Model 10h introduced systems with one mask per Chip Select,
dfcd741f577d12 Yazen Ghannam          2021-12-28  1945  	 * and two Chip Selects per DIMM.
dfcd741f577d12 Yazen Ghannam          2021-12-28  1946  	 *
dfcd741f577d12 Yazen Ghannam          2021-12-28  1947  	 *	CS0 -> MASK0 -> DIMM0
dfcd741f577d12 Yazen Ghannam          2021-12-28  1948  	 *	CS1 -> MASK1 -> DIMM0
dfcd741f577d12 Yazen Ghannam          2021-12-28  1949  	 *	CS2 -> MASK2 -> DIMM1
dfcd741f577d12 Yazen Ghannam          2021-12-28  1950  	 *	CS3 -> MASK3 -> DIMM1
dfcd741f577d12 Yazen Ghannam          2021-12-28  1951  	 *
dfcd741f577d12 Yazen Ghannam          2021-12-28  1952  	 * Keep the mask number equal to the Chip Select number for newer systems,
dfcd741f577d12 Yazen Ghannam          2021-12-28  1953  	 * and shift the mask number for older systems.
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1954  	 */
dfcd741f577d12 Yazen Ghannam          2021-12-28  1955  	if (!fam_type->flags.zn_regs_v2)
dfcd741f577d12 Yazen Ghannam          2021-12-28  1956  		cs_mask_nr >>= 1;
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1957  
81f5090db843be Yazen Ghannam          2019-08-22  1958  	/* Asymmetric dual-rank DIMM support. */
81f5090db843be Yazen Ghannam          2019-08-22  1959  	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
dfcd741f577d12 Yazen Ghannam          2021-12-28  1960  		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
81f5090db843be Yazen Ghannam          2019-08-22  1961  	else
dfcd741f577d12 Yazen Ghannam          2021-12-28  1962  		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1963  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1964  	/*
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1965  	 * The number of zero bits in the mask is equal to the number of bits
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1966  	 * in a full mask minus the number of bits in the current mask.
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1967  	 *
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1968  	 * The MSB is the number of bits in the full mask because BIT[0] is
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1969  	 * always 0.
9f4873fb6af796 Yazen Ghannam          2021-10-05  1970  	 *
9f4873fb6af796 Yazen Ghannam          2021-10-05  1971  	 * In the special 3 Rank interleaving case, a single bit is flipped
9f4873fb6af796 Yazen Ghannam          2021-10-05  1972  	 * without swapping with the most significant bit. This can be handled
9f4873fb6af796 Yazen Ghannam          2021-10-05  1973  	 * by keeping the MSB where it is and ignoring the single zero bit.
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1974  	 */
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1975  	msb = fls(addr_mask_orig) - 1;
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1976  	weight = hweight_long(addr_mask_orig);
9f4873fb6af796 Yazen Ghannam          2021-10-05  1977  	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1978  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1979  	/* Take the number of zero bits off from the top of the mask. */
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1980  	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1981  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21 @1982  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1983  	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1984  	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1985  
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1986  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
e53a3b267fb0a7 Yazen Ghannam          2019-08-21  1987  	size = (addr_mask_deinterleaved >> 2) + 1;
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1988  
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1989  	/* Return size in MBs. */
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1990  	return size >> 10;
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1991  }
f1cbbec9fce958 Yazen Ghannam          2016-11-17  1992  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
