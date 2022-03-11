Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0554D6A2E
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 00:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiCKX1H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 18:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiCKX1G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 18:27:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E379199D5F;
        Fri, 11 Mar 2022 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647041162; x=1678577162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhLI30JK+BcSkM8Wok3yK+8l0ZbaHT6oDrtnpTgbszc=;
  b=m8B27ayD/7OISSMPiu3ZaeELECmxjGivtoLI4UoW6/fYAvEYmwP5LbFv
   nqZvvyFBlmzL3JKEtM9OZnLrXPzm6AZiyvGjmClkUWCDmXJuX8ahMDEDX
   fEYAuOD3zFF/9lr1XsldRUpj9H7m3lnQxdcKe5LIKRIB8in2s70fY2t3o
   +NkeGHcGLFsQWpwIg8F6Ml2V17iFiUbgUVRPYfEJZ/6MLX1IGJOseofhD
   mJ0Id1IV6ZtykBkUuX0jvSB+Kx2w4EA9A90kfSVVF1wIeetOpMLO7tRUa
   JlKuXgA1UAyocXLS/mXZSMWfW2CHGSULDtNDwIC+aqufxXlNTzhz+jJnC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237843541"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237843541"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="579448467"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 15:25:56 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSodv-0007FQ-CD; Fri, 11 Mar 2022 23:25:55 +0000
Date:   Sat, 12 Mar 2022 07:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     kbuild-all@lists.01.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Message-ID: <202203120713.ExrZZZo2-lkp@intel.com>
References: <20220311014245.4612-4-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311014245.4612-4-ctcchien@nuvoton.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Medad,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ras/edac-for-next]
[also build test ERROR on robh/for-next v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Medad-CChien/EDAC-nuvoton-Add-nuvoton-NPCM-memory-controller-driver/20220311-094500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203120713.ExrZZZo2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6cb0bb6039e1ce83a8d67c6d571abd2a45e82b10
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Medad-CChien/EDAC-nuvoton-Add-nuvoton-NPCM-memory-controller-driver/20220311-094500
        git checkout 6cb0bb6039e1ce83a8d67c6d571abd2a45e82b10
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ arch/arm/mach-imx/ arch/arm/mach-omap2/ arch/arm/mach-socfpga/ arch/arm/mach-tegra/ drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/edac/npcm_edac.c: In function 'forced_ecc_error_store':
   drivers/edac/npcm_edac.c:370:13: warning: suggest parentheses around operand of '!' or change '&' to '&&' or '!' to '~' [-Wparentheses]
     370 |         if (!readl(priv->reg + npcm_chip->ecc_ctl_en_reg) & npcm_chip->ecc_ctl_ecc_enable_mask)
>> drivers/edac/npcm_edac.c:386:92: error: macro "edac_printk" requires 4 arguments, but only 2 given
     386 |                                 edac_printk(KERN_INFO, "bit_no for checkcode must be 0~7\n");
         |                                                                                            ^
   In file included from drivers/edac/edac_module.h:14,
                    from drivers/edac/npcm_edac.c:15:
   drivers/edac/edac_mc.h:48: note: macro "edac_printk" defined here
      48 | #define edac_printk(level, prefix, fmt, arg...) \
         | 
>> drivers/edac/npcm_edac.c:386:33: error: 'edac_printk' undeclared (first use in this function); did you mean '_dev_printk'?
     386 |                                 edac_printk(KERN_INFO, "bit_no for checkcode must be 0~7\n");
         |                                 ^~~~~~~~~~~
         |                                 _dev_printk
   drivers/edac/npcm_edac.c:386:33: note: each undeclared identifier is reported only once for each function it appears in
   drivers/edac/npcm_edac.c:395:88: error: macro "edac_printk" requires 4 arguments, but only 2 given
     395 |                                 edac_printk(KERN_INFO, "bit_no for data must be 0~63\n");
         |                                                                                        ^
   In file included from drivers/edac/edac_module.h:14,
                    from drivers/edac/npcm_edac.c:15:
   drivers/edac/edac_mc.h:48: note: macro "edac_printk" defined here
      48 | #define edac_printk(level, prefix, fmt, arg...) \
         | 
   drivers/edac/npcm_edac.c: In function 'npcm_edac_mc_probe':
   drivers/edac/npcm_edac.c:583:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     583 |         u32 ecc_en = readl(reg + npcm_chip->ecc_ctl_en_reg);
         |         ^~~


vim +/edac_printk +386 drivers/edac/npcm_edac.c

   352	
   353	static ssize_t forced_ecc_error_store(struct device *dev,
   354					      struct device_attribute *mattr,
   355					      const char *data, size_t count)
   356	{
   357		struct mem_ctl_info *mci = to_mci(dev);
   358		struct priv_data *priv = mci->pvt_info;
   359		const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
   360		int	args_cnt;
   361		int	ret;
   362		char	**args;
   363		u32	regval;
   364		u8	bit_no;
   365	
   366		/* Split string buffer into separate parameters */
   367		args = argv_split(GFP_KERNEL, data, &args_cnt);
   368	
   369		/* Check ecc enabled */
   370		if (!readl(priv->reg + npcm_chip->ecc_ctl_en_reg) & npcm_chip->ecc_ctl_ecc_enable_mask)
   371			return count;
   372	
   373		/* Check no write operation pending to controller*/
   374		while (readl(priv->reg + npcm_chip->ddr_ctl_controller_busy_reg) &
   375				CTL_CONTROLLER_BUSY_FLAG) {
   376			usleep_range(1000, 10000);
   377		}
   378	
   379		/* Write appropriate syndrome to xor_check_bit*/
   380		if (!strcmp(args[0], "CE") && args_cnt == 3) {
   381			ret = kstrtou8(args[2], 0, &bit_no);
   382			if (ret)
   383				return ret;
   384			if (!strcmp(args[1], "checkcode")) {
   385				if (bit_no > 7) {
 > 386					edac_printk(KERN_INFO, "bit_no for checkcode must be 0~7\n");
   387					return count;
   388				}
   389				regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   390				regval = (regval & ~(NPCM_ECC_CTL_XOR_BITS_MASK)) |
   391					(check_synd[bit_no] << XOR_CHECK_BIT_SPLIT_WIDTH);
   392				writel(regval, priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   393			} else if (!strcmp(args[1], "data")) {
   394				if (bit_no > 63) {
   395					edac_printk(KERN_INFO, "bit_no for data must be 0~63\n");
   396					return count;
   397				}
   398				regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   399				regval = (regval & ~(NPCM_ECC_CTL_XOR_BITS_MASK)) |
   400						 (data_synd[bit_no] << XOR_CHECK_BIT_SPLIT_WIDTH);
   401				writel(regval, priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   402			}
   403			/* Enable the ECC writeback_en for corrected error */
   404			regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   405			writel((regval | NPCM_ECC_CTL_AUTO_WRITEBACK_EN),
   406			       priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   407		} else if (!strcmp(args[0], "UE")) {
   408			regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   409			regval = (regval & ~(NPCM_ECC_CTL_XOR_BITS_MASK)) |
   410					 (ECC_DOUBLE_MULTI_ERR_SYND << XOR_CHECK_BIT_SPLIT_WIDTH);
   411			writel(regval, priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   412		}
   413	
   414		/* Assert fwc */
   415		writel((NPCM_ECC_CTL_FORCE_WC | readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg)),
   416		       priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
   417	
   418		return count;
   419	}
   420	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
