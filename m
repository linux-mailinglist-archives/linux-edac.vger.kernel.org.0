Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74245A2BD3
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiHZQAJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiHZQAI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 12:00:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D15F238;
        Fri, 26 Aug 2022 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661529606; x=1693065606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IPRRKVfITe68K+sJd+NzcFp4p9F5uw+AGCySW9Jrtag=;
  b=DKk/Z9mZhH2TSW/+A3M3uXvVgqW3tflYLOo6VESCfCkz0yDwEccWwaEg
   0apnqcR151NETruSUNUwuAc+ZzHhM7gn+t7uZLlehzYRBff8FIyTqrNLQ
   k3Y+vPSBQ9r6eHTpDbz9htQye3wJGrewiGJpYfruQ5wX2mzNgFdC8XLyh
   q2Ne+sakC9WmJSzyO7HzFjXAKFrpCF5mHhykbVdQGXoJD+8C04qJNXl1b
   ydrSeU2qbIUE2O5zRt4HKCljcvxYjg1cjKfdXc4av1XkllkU0wkOmAdIB
   TzOH7cgMBeANY13QtbcWgbB0jQmdiVjXycy9LjPq7dwYkdVapUho68LlQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293278270"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293278270"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 09:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="752915829"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2022 09:00:01 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRbkW-00005F-2W;
        Fri, 26 Aug 2022 16:00:00 +0000
Date:   Fri, 26 Aug 2022 23:59:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marvin Lin <milkfafa@gmail.com>, linux-edac@vger.kernel.org,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: Re: [PATCH v13 3/3] EDAC/nuvoton: Add NPCM memory controller driver
Message-ID: <202208262327.xR9E62aK-lkp@intel.com>
References: <20220816094641.8484-4-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816094641.8484-4-milkfafa@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Marvin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on robh/for-next linus/master v6.0-rc2 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marvin-Lin/EDAC-nuvoton-Add-NPCM-memory-controller-driver/20220816-192514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220826/202208262327.xR9E62aK-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/869724e680023a78ccf48489cf12da04e9317347
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marvin-Lin/EDAC-nuvoton-Add-NPCM-memory-controller-driver/20220816-192514
        git checkout 869724e680023a78ccf48489cf12da04e9317347
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/edac/npcm_edac.c: In function 'force_ecc_error':
>> drivers/edac/npcm_edac.c:192:44: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     192 |         struct npcm_platform_data *pdata = priv->pdata;
         |                                            ^~~~
   drivers/edac/npcm_edac.c: In function 'handle_ce':
>> drivers/edac/npcm_edac.c:107:23: warning: 'addr' is used uninitialized [-Wuninitialized]
     107 |         addr = ((addr | val_h) << 32) | val_l;
         |                 ~~~~~~^~~~~~~~
   drivers/edac/npcm_edac.c:99:13: note: 'addr' was declared here
      99 |         u64 addr, data;
         |             ^~~~
>> drivers/edac/npcm_edac.c:112:23: warning: 'data' is used uninitialized [-Wuninitialized]
     112 |         data = ((data | val_h) << 32) | val_l;
         |                 ~~~~~~^~~~~~~~
   drivers/edac/npcm_edac.c:99:19: note: 'data' was declared here
      99 |         u64 addr, data;
         |                   ^~~~
   drivers/edac/npcm_edac.c: In function 'handle_ue':
   drivers/edac/npcm_edac.c:139:23: warning: 'addr' is used uninitialized [-Wuninitialized]
     139 |         addr = ((addr | val_h) << 32) | val_l;
         |                 ~~~~~~^~~~~~~~
   drivers/edac/npcm_edac.c:131:13: note: 'addr' was declared here
     131 |         u64 addr, data;
         |             ^~~~
   drivers/edac/npcm_edac.c:144:23: warning: 'data' is used uninitialized [-Wuninitialized]
     144 |         data = ((data | val_h) << 32) | val_l;
         |                 ~~~~~~^~~~~~~~
   drivers/edac/npcm_edac.c:131:19: note: 'data' was declared here
     131 |         u64 addr, data;
         |                   ^~~~


vim +/const +192 drivers/edac/npcm_edac.c

    94	
    95	static void handle_ce(struct mem_ctl_info *mci)
    96	{
    97		struct priv_data *priv = mci->pvt_info;
    98		const struct npcm_platform_data *pdata = priv->pdata;
    99		u64 addr, data;
   100		u32 val_l, val_h, id, synd;
   101	
   102		regmap_read(npcm_regmap, pdata->ctl_ce_addr_l, &val_l);
   103		if (pdata->chip == NPCM8XX_CHIP) {
   104			regmap_read(npcm_regmap, pdata->ctl_ce_addr_h, &val_h);
   105			val_h &= pdata->ce_addr_h_mask;
   106		}
 > 107		addr = ((addr | val_h) << 32) | val_l;
   108	
   109		regmap_read(npcm_regmap, pdata->ctl_ce_data_l, &val_l);
   110		if (pdata->chip == NPCM8XX_CHIP)
   111			regmap_read(npcm_regmap, pdata->ctl_ce_data_h, &val_h);
 > 112		data = ((data | val_h) << 32) | val_l;
   113	
   114		regmap_read(npcm_regmap, pdata->ctl_source_id, &id);
   115		id = (id & pdata->source_id_ce_mask) >> pdata->source_id_ce_shift;
   116	
   117		regmap_read(npcm_regmap, pdata->ctl_ce_synd, &synd);
   118		synd = (synd & pdata->ce_synd_mask) >> pdata->ce_synd_shift;
   119	
   120		snprintf(priv->message, EDAC_MSG_SIZE,
   121			 "addr = 0x%llx, data = 0x%llx, id = 0x%x", addr, data, id);
   122	
   123		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, addr >> PAGE_SHIFT,
   124				     addr & ~PAGE_MASK, synd, 0, 0, -1, priv->message, "");
   125	}
   126	
   127	static void handle_ue(struct mem_ctl_info *mci)
   128	{
   129		struct priv_data *priv = mci->pvt_info;
   130		const struct npcm_platform_data *pdata = priv->pdata;
   131		u64 addr, data;
   132		u32 val_l, val_h, id, synd;
   133	
   134		regmap_read(npcm_regmap, pdata->ctl_ue_addr_l, &val_l);
   135		if (pdata->chip == NPCM8XX_CHIP) {
   136			regmap_read(npcm_regmap, pdata->ctl_ue_addr_h, &val_h);
   137			val_h &= pdata->ue_addr_h_mask;
   138		}
   139		addr = ((addr | val_h) << 32) | val_l;
   140	
   141		regmap_read(npcm_regmap, pdata->ctl_ue_data_l, &val_l);
   142		if (pdata->chip == NPCM8XX_CHIP)
   143			regmap_read(npcm_regmap, pdata->ctl_ue_data_h, &val_h);
   144		data = ((data | val_h) << 32) | val_l;
   145	
   146		regmap_read(npcm_regmap, pdata->ctl_source_id, &id);
   147		id = (id & pdata->source_id_ue_mask) >> pdata->source_id_ue_shift;
   148	
   149		regmap_read(npcm_regmap, pdata->ctl_ue_synd, &synd);
   150		synd = (synd & pdata->ue_synd_mask) >> pdata->ue_synd_shift;
   151	
   152		snprintf(priv->message, EDAC_MSG_SIZE,
   153			 "addr = 0x%llx, data = 0x%llx, id = 0x%x", addr, data, id);
   154	
   155		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, addr >> PAGE_SHIFT,
   156				     addr & ~PAGE_MASK, synd, 0, 0, -1, priv->message, "");
   157	}
   158	
   159	static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
   160	{
   161		struct mem_ctl_info *mci = dev_id;
   162		struct priv_data *priv = mci->pvt_info;
   163		const struct npcm_platform_data *pdata = priv->pdata;
   164		u32 status;
   165	
   166		regmap_read(npcm_regmap, pdata->ctl_int_status, &status);
   167		if (status & pdata->int_status_ce_mask) {
   168			handle_ce(mci);
   169	
   170			/* acknowledge the CE interrupt */
   171			regmap_write(npcm_regmap, pdata->ctl_int_ack,
   172				     pdata->int_ack_ce_mask);
   173			return IRQ_HANDLED;
   174		} else if (status & pdata->int_status_ue_mask) {
   175			handle_ue(mci);
   176	
   177			/* acknowledge the UE interrupt */
   178			regmap_write(npcm_regmap, pdata->ctl_int_ack,
   179				     pdata->int_ack_ue_mask);
   180			return IRQ_HANDLED;
   181		}
   182	
   183		return IRQ_NONE;
   184	}
   185	
   186	static ssize_t force_ecc_error(struct file *file, const char __user *data,
   187					    size_t count, loff_t *ppos)
   188	{
   189		struct device *dev = file->private_data;
   190		struct mem_ctl_info *mci = to_mci(dev);
   191		struct priv_data *priv = mci->pvt_info;
 > 192		struct npcm_platform_data *pdata = priv->pdata;
   193		int ret;
   194		u32 val, syndrome;
   195	
   196		/*
   197		 * error_type - 0: CE, 1: UE
   198		 * location   - 0: data, 1: checkcode
   199		 * bit        - 0 ~ 63 for data and 0 ~ 7 for checkcode
   200		 */
   201		edac_printk(KERN_INFO, EDAC_MOD_NAME,
   202			    "force an ECC error, type = %d, location = %d, bit = %d\n",
   203			    priv->error_type, priv->location, priv->bit);
   204	
   205		/* ensure no pending writes */
   206		ret = regmap_read_poll_timeout(npcm_regmap, pdata->ctl_controller_busy,
   207					       val, !(val & pdata->controller_busy_mask),
   208					       1000, 10000);
   209		if (ret) {
   210			edac_printk(KERN_INFO, EDAC_MOD_NAME,
   211				    "wait pending writes timeout\n");
   212			return count;
   213		}
   214	
   215		regmap_read(npcm_regmap, pdata->ctl_xor_check_bits, &val);
   216		val &= ~pdata->xor_check_bits_mask;
   217	
   218		/* write syndrome to XOR_CHECK_BITS */
   219		if (priv->error_type == 0) {
   220			if (priv->location == 0 && priv->bit > 63) {
   221				edac_printk(KERN_INFO, EDAC_MOD_NAME,
   222					    "data bit should not exceed 63\n");
   223				return count;
   224			}
   225	
   226			if (priv->location == 1 && priv->bit > 7) {
   227				edac_printk(KERN_INFO, EDAC_MOD_NAME,
   228					    "checkcode bit should not exceed 7\n");
   229				return count;
   230			}
   231	
   232			syndrome = priv->location ? 1 << priv->bit :
   233				   data_synd[priv->bit];
   234	
   235			regmap_write(npcm_regmap, pdata->ctl_xor_check_bits,
   236				     val | (syndrome << pdata->xor_check_bits_shift) |
   237				     pdata->writeback_en_mask);
   238		} else if (priv->error_type == 1) {
   239			regmap_write(npcm_regmap, pdata->ctl_xor_check_bits,
   240				     val | (UE_SYNDROME << pdata->xor_check_bits_shift));
   241		}
   242	
   243		/* force write check */
   244		regmap_update_bits(npcm_regmap, pdata->ctl_xor_check_bits,
   245				   pdata->fwc_mask, pdata->fwc_mask);
   246	
   247		return count;
   248	}
   249	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
