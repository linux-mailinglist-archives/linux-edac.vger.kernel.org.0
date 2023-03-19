Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20216C04FD
	for <lists+linux-edac@lfdr.de>; Sun, 19 Mar 2023 21:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCSUy1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Mar 2023 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCSUy0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Mar 2023 16:54:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BDE72A2;
        Sun, 19 Mar 2023 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679259264; x=1710795264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y5cIElhvg8EPw65qGruKREHutSyGtcC3oL5nutI/Bj0=;
  b=H4zylHif4+Zu8aajj30t2K5GZMqO8JbOvXp791r53v0aq2IglIIxlbeE
   jRsmDJTbp1ONCcvbLkFVATO/CE+NKtJeHMnMt2iQWbKi276Bi2JW6hnBr
   To/s9LkAMswx2oOda+OwhMwVjT4e67yGJA1eCNxEoipSAEM+Wq5WvHRjA
   VICFBHgXsUhR+JWjnDhY93T8xHfTue7Lou3guD+zu/dXN5JAKQVHoiE3k
   akmaycDhb2XhUz4FI+gSXkMtz0wFU1CoSQe1mjI3NMnWMJ6mSME9hNUP0
   GpSlrSV9NWmR2hnrKZwEKbEeQJf37Sn2TctB5tZCULfI7+43fkSIIDoaR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424813940"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424813940"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 13:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="680858554"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="680858554"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2023 13:54:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pe02m-000AeU-1S;
        Sun, 19 Mar 2023 20:54:20 +0000
Date:   Mon, 20 Mar 2023 04:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Use of_address_to_resource()
Message-ID: <202303200438.ZFr6mEnr-lkp@intel.com>
References: <20230319163224.226479-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319163224.226479-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rob,

I love your patch! Yet something to improve:

[auto build test ERROR on ras/edac-for-next]
[cannot apply to bp/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/EDAC-Use-of_address_to_resource/20230320-003703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20230319163224.226479-1-robh%40kernel.org
patch subject: [PATCH] EDAC: Use of_address_to_resource()
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230320/202303200438.ZFr6mEnr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a128482ade3b4c37d55aa60604caf14e4570fbe5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rob-Herring/EDAC-Use-of_address_to_resource/20230320-003703
        git checkout a128482ade3b4c37d55aa60604caf14e4570fbe5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303200438.ZFr6mEnr-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/edac/altera_edac.c: In function 'altr_s10_sdram_check_ecc_deps':
>> drivers/edac/altera_edac.c:1108:25: error: invalid type argument of '->' (have 'struct resource')
    1108 |         sdram_addr = res->start;
         |                         ^~


vim +1108 drivers/edac/altera_edac.c

  1085	
  1086	/*
  1087	 * A legacy U-Boot bug only enabled memory mapped access to the ECC Enable
  1088	 * register if ECC is enabled. Linux checks the ECC Enable register to
  1089	 * determine ECC status.
  1090	 * Use an SMC call (which always works) to determine ECC enablement.
  1091	 */
  1092	static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
  1093	{
  1094		const struct edac_device_prv_data *prv = device->data;
  1095		unsigned long sdram_ecc_addr;
  1096		struct arm_smccc_res result;
  1097		struct device_node *np;
  1098		phys_addr_t sdram_addr;
  1099		struct resource res;
  1100		u32 read_reg;
  1101		int ret;
  1102	
  1103		np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
  1104		if (!np)
  1105			goto sdram_err;
  1106	
  1107		of_address_to_resource(np, 0, &res);
> 1108		sdram_addr = res->start;
  1109		of_node_put(np);
  1110		sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
  1111		arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
  1112			      0, 0, 0, 0, 0, 0, &result);
  1113		read_reg = (unsigned int)result.a1;
  1114		ret = (int)result.a0;
  1115		if (!ret && (read_reg & prv->ecc_enable_mask))
  1116			return 0;
  1117	
  1118	sdram_err:
  1119		edac_printk(KERN_ERR, EDAC_DEVICE,
  1120			    "%s: No ECC present or ECC disabled.\n",
  1121			    device->edac_dev_name);
  1122		return -ENODEV;
  1123	}
  1124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
