Return-Path: <linux-edac+bounces-4295-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F3AEED03
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 05:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64163B7B39
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D6165F16;
	Tue,  1 Jul 2025 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WE7RjDLH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531411CAB3
	for <linux-edac@vger.kernel.org>; Tue,  1 Jul 2025 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751340453; cv=none; b=dVJLpddXCSG+pjWTSqChV3XvBgvAAbiI/BFlAKcGOd/taFPz0TFZLDkkXpstrjJY+4jU4Lld5hVCZAf7oxnQGGUCN93bG30BT3V2lGBDYIrdtA/w+hlY5tWbwwfJHgtafvI1934vf2Hwpdd3mACxv7AW5pDS39noGIsy+VItVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751340453; c=relaxed/simple;
	bh=zawUcA5192ppHc1EG6RNnQCz/R56ED+S6MRNw6xKo/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbSlQC9xDNqDD64gD4FOYHg/Jk2XPYLM/BmvGQhYbUiWz9B6QDEw2fK6nqqE3yjG1/TJSnLF/Awt9fzWum6fTpWal3YVZ7YjbZMb9DoUY4Y2nrX9A3kxaFBWXRSvdROstGYYCXlKHBd1xQpRolFpaYKLX9P6CH2SwGjL+cUS79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WE7RjDLH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751340450; x=1782876450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zawUcA5192ppHc1EG6RNnQCz/R56ED+S6MRNw6xKo/I=;
  b=WE7RjDLH6ch6UJaQIjLrzy8ozw3Fo01+xjWXcbGX3MeyxSBfILvUMwi3
   FD8YlIAmr0KLNPrVWqN6ISN90KLyYduMkKHqbzuDJ3DaPJo2mdE16zYPs
   Erv9fDnlOHfcmhiGs+bdSiJd+UCRCkRtLfGndJQLsVWf5nFFYlNwB4I3U
   2pK6iosoQ4fhYGJEF+ZPcMzjdAPx/ZRHsUueuxEJGEPMkDkfz/Emj2pXi
   XqF3uD/9TUsGgYHwwUI/Q/JQNx78+kjUJ+7SQX98hKLAcivygt0Ct4v7V
   J5oykGN8B/0NDhyXumORhata10B9MuuLunHHDghisCbcY6Uccfm7I/pQF
   A==;
X-CSE-ConnectionGUID: TwrfnIxNRpml6ByuyeBjHQ==
X-CSE-MsgGUID: qoFVF8LZSKSG867C7WM35g==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53521531"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53521531"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 20:27:30 -0700
X-CSE-ConnectionGUID: loj8cLcpSgC3VgPQ+/kXow==
X-CSE-MsgGUID: 17V7O5vpQw6tB5hnoroAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154165178"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2025 20:27:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWReW-000Zgo-2L;
	Tue, 01 Jul 2025 03:27:24 +0000
Date: Tue, 1 Jul 2025 11:27:20 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, arnd@kernel.org, mchehab@kernel.org,
	rric@kernel.org, dave.jiang@intel.com, jonathan.cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	shiju.jose@huawei.com
Subject: Re: [PATCH 2/2] EDAC/ecs: Reduce stack usage in ecs_create_desc()
Message-ID: <202507011111.3D1OQtAM-lkp@intel.com>
References: <20250630162034.1788-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630162034.1788-3-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on ras/edac-for-next]
[cannot apply to linus/master v6.16-rc4 next-20250630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/EDAC-scrub-Reduce-stack-usage-in-scrub_create_desc/20250701-002641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20250630162034.1788-3-shiju.jose%40huawei.com
patch subject: [PATCH 2/2] EDAC/ecs: Reduce stack usage in ecs_create_desc()
config: x86_64-randconfig-073-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011111.3D1OQtAM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507011111.3D1OQtAM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011111.3D1OQtAM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/edac.h:16,
                    from drivers/edac/ecs.c:10:
   drivers/edac/ecs.c: In function 'ecs_create_desc':
>> drivers/edac/ecs.c:167:51: error: 'struct edac_ecs_fru_context' has no member named 'dev_attr'; did you mean 'ecs_dev_attr'?
     167 |                         sysfs_attr_init(&fru_ctx->dev_attr[i].dev_attr.attr);
         |                                                   ^~~~~~~~
   include/linux/sysfs.h:55:10: note: in definition of macro 'sysfs_attr_init'
      55 |         (attr)->key = &__key;                           \
         |          ^~~~


vim +167 drivers/edac/ecs.c

bcbd069b11b024 Shiju Jose 2025-02-12  @10  #include <linux/edac.h>
bcbd069b11b024 Shiju Jose 2025-02-12   11  
bcbd069b11b024 Shiju Jose 2025-02-12   12  #define EDAC_ECS_FRU_NAME "ecs_fru"
bcbd069b11b024 Shiju Jose 2025-02-12   13  
bcbd069b11b024 Shiju Jose 2025-02-12   14  enum edac_ecs_attributes {
bcbd069b11b024 Shiju Jose 2025-02-12   15  	ECS_LOG_ENTRY_TYPE,
bcbd069b11b024 Shiju Jose 2025-02-12   16  	ECS_MODE,
bcbd069b11b024 Shiju Jose 2025-02-12   17  	ECS_RESET,
bcbd069b11b024 Shiju Jose 2025-02-12   18  	ECS_THRESHOLD,
bcbd069b11b024 Shiju Jose 2025-02-12   19  	ECS_MAX_ATTRS
bcbd069b11b024 Shiju Jose 2025-02-12   20  };
bcbd069b11b024 Shiju Jose 2025-02-12   21  
bcbd069b11b024 Shiju Jose 2025-02-12   22  struct edac_ecs_dev_attr {
bcbd069b11b024 Shiju Jose 2025-02-12   23  	struct device_attribute dev_attr;
bcbd069b11b024 Shiju Jose 2025-02-12   24  	int fru_id;
bcbd069b11b024 Shiju Jose 2025-02-12   25  };
bcbd069b11b024 Shiju Jose 2025-02-12   26  
bcbd069b11b024 Shiju Jose 2025-02-12   27  struct edac_ecs_fru_context {
bcbd069b11b024 Shiju Jose 2025-02-12   28  	char name[EDAC_FEAT_NAME_LEN];
df1b3160633d4f Shiju Jose 2025-06-30   29  	struct edac_ecs_dev_attr ecs_dev_attr[ECS_MAX_ATTRS];
bcbd069b11b024 Shiju Jose 2025-02-12   30  	struct attribute *ecs_attrs[ECS_MAX_ATTRS + 1];
bcbd069b11b024 Shiju Jose 2025-02-12   31  	struct attribute_group group;
bcbd069b11b024 Shiju Jose 2025-02-12   32  };
bcbd069b11b024 Shiju Jose 2025-02-12   33  
bcbd069b11b024 Shiju Jose 2025-02-12   34  struct edac_ecs_context {
bcbd069b11b024 Shiju Jose 2025-02-12   35  	u16 num_media_frus;
bcbd069b11b024 Shiju Jose 2025-02-12   36  	struct edac_ecs_fru_context *fru_ctxs;
bcbd069b11b024 Shiju Jose 2025-02-12   37  };
bcbd069b11b024 Shiju Jose 2025-02-12   38  
bcbd069b11b024 Shiju Jose 2025-02-12   39  #define TO_ECS_DEV_ATTR(_dev_attr)	\
bcbd069b11b024 Shiju Jose 2025-02-12   40  	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
bcbd069b11b024 Shiju Jose 2025-02-12   41  
bcbd069b11b024 Shiju Jose 2025-02-12   42  #define EDAC_ECS_ATTR_SHOW(attrib, cb, type, format)				\
bcbd069b11b024 Shiju Jose 2025-02-12   43  static ssize_t attrib##_show(struct device *ras_feat_dev,			\
bcbd069b11b024 Shiju Jose 2025-02-12   44  			     struct device_attribute *attr, char *buf)		\
bcbd069b11b024 Shiju Jose 2025-02-12   45  {										\
bcbd069b11b024 Shiju Jose 2025-02-12   46  	struct edac_ecs_dev_attr *dev_attr = TO_ECS_DEV_ATTR(attr);		\
bcbd069b11b024 Shiju Jose 2025-02-12   47  	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
bcbd069b11b024 Shiju Jose 2025-02-12   48  	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;			\
bcbd069b11b024 Shiju Jose 2025-02-12   49  	type data;								\
bcbd069b11b024 Shiju Jose 2025-02-12   50  	int ret;								\
bcbd069b11b024 Shiju Jose 2025-02-12   51  										\
bcbd069b11b024 Shiju Jose 2025-02-12   52  	ret = ops->cb(ras_feat_dev->parent, ctx->ecs.private,			\
bcbd069b11b024 Shiju Jose 2025-02-12   53  		      dev_attr->fru_id, &data);					\
bcbd069b11b024 Shiju Jose 2025-02-12   54  	if (ret)								\
bcbd069b11b024 Shiju Jose 2025-02-12   55  		return ret;							\
bcbd069b11b024 Shiju Jose 2025-02-12   56  										\
bcbd069b11b024 Shiju Jose 2025-02-12   57  	return sysfs_emit(buf, format, data);					\
bcbd069b11b024 Shiju Jose 2025-02-12   58  }
bcbd069b11b024 Shiju Jose 2025-02-12   59  
bcbd069b11b024 Shiju Jose 2025-02-12   60  EDAC_ECS_ATTR_SHOW(log_entry_type, get_log_entry_type, u32, "%u\n")
bcbd069b11b024 Shiju Jose 2025-02-12   61  EDAC_ECS_ATTR_SHOW(mode, get_mode, u32, "%u\n")
bcbd069b11b024 Shiju Jose 2025-02-12   62  EDAC_ECS_ATTR_SHOW(threshold, get_threshold, u32, "%u\n")
bcbd069b11b024 Shiju Jose 2025-02-12   63  
bcbd069b11b024 Shiju Jose 2025-02-12   64  #define EDAC_ECS_ATTR_STORE(attrib, cb, type, conv_func)			\
bcbd069b11b024 Shiju Jose 2025-02-12   65  static ssize_t attrib##_store(struct device *ras_feat_dev,			\
bcbd069b11b024 Shiju Jose 2025-02-12   66  			      struct device_attribute *attr,			\
bcbd069b11b024 Shiju Jose 2025-02-12   67  			      const char *buf, size_t len)			\
bcbd069b11b024 Shiju Jose 2025-02-12   68  {										\
bcbd069b11b024 Shiju Jose 2025-02-12   69  	struct edac_ecs_dev_attr *dev_attr = TO_ECS_DEV_ATTR(attr);		\
bcbd069b11b024 Shiju Jose 2025-02-12   70  	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
bcbd069b11b024 Shiju Jose 2025-02-12   71  	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;			\
bcbd069b11b024 Shiju Jose 2025-02-12   72  	type data;								\
bcbd069b11b024 Shiju Jose 2025-02-12   73  	int ret;								\
bcbd069b11b024 Shiju Jose 2025-02-12   74  										\
bcbd069b11b024 Shiju Jose 2025-02-12   75  	ret = conv_func(buf, 0, &data);						\
bcbd069b11b024 Shiju Jose 2025-02-12   76  	if (ret < 0)								\
bcbd069b11b024 Shiju Jose 2025-02-12   77  		return ret;							\
bcbd069b11b024 Shiju Jose 2025-02-12   78  										\
bcbd069b11b024 Shiju Jose 2025-02-12   79  	ret = ops->cb(ras_feat_dev->parent, ctx->ecs.private,			\
bcbd069b11b024 Shiju Jose 2025-02-12   80  		      dev_attr->fru_id, data);					\
bcbd069b11b024 Shiju Jose 2025-02-12   81  	if (ret)								\
bcbd069b11b024 Shiju Jose 2025-02-12   82  		return ret;							\
bcbd069b11b024 Shiju Jose 2025-02-12   83  										\
bcbd069b11b024 Shiju Jose 2025-02-12   84  	return len;								\
bcbd069b11b024 Shiju Jose 2025-02-12   85  }
bcbd069b11b024 Shiju Jose 2025-02-12   86  
bcbd069b11b024 Shiju Jose 2025-02-12   87  EDAC_ECS_ATTR_STORE(log_entry_type, set_log_entry_type, unsigned long, kstrtoul)
bcbd069b11b024 Shiju Jose 2025-02-12   88  EDAC_ECS_ATTR_STORE(mode, set_mode, unsigned long, kstrtoul)
bcbd069b11b024 Shiju Jose 2025-02-12   89  EDAC_ECS_ATTR_STORE(reset, reset, unsigned long, kstrtoul)
bcbd069b11b024 Shiju Jose 2025-02-12   90  EDAC_ECS_ATTR_STORE(threshold, set_threshold, unsigned long, kstrtoul)
bcbd069b11b024 Shiju Jose 2025-02-12   91  
bcbd069b11b024 Shiju Jose 2025-02-12   92  static umode_t ecs_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
bcbd069b11b024 Shiju Jose 2025-02-12   93  {
bcbd069b11b024 Shiju Jose 2025-02-12   94  	struct device *ras_feat_dev = kobj_to_dev(kobj);
bcbd069b11b024 Shiju Jose 2025-02-12   95  	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
bcbd069b11b024 Shiju Jose 2025-02-12   96  	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
bcbd069b11b024 Shiju Jose 2025-02-12   97  
bcbd069b11b024 Shiju Jose 2025-02-12   98  	switch (attr_id) {
bcbd069b11b024 Shiju Jose 2025-02-12   99  	case ECS_LOG_ENTRY_TYPE:
bcbd069b11b024 Shiju Jose 2025-02-12  100  		if (ops->get_log_entry_type)  {
bcbd069b11b024 Shiju Jose 2025-02-12  101  			if (ops->set_log_entry_type)
bcbd069b11b024 Shiju Jose 2025-02-12  102  				return a->mode;
bcbd069b11b024 Shiju Jose 2025-02-12  103  			else
bcbd069b11b024 Shiju Jose 2025-02-12  104  				return 0444;
bcbd069b11b024 Shiju Jose 2025-02-12  105  		}
bcbd069b11b024 Shiju Jose 2025-02-12  106  		break;
bcbd069b11b024 Shiju Jose 2025-02-12  107  	case ECS_MODE:
bcbd069b11b024 Shiju Jose 2025-02-12  108  		if (ops->get_mode) {
bcbd069b11b024 Shiju Jose 2025-02-12  109  			if (ops->set_mode)
bcbd069b11b024 Shiju Jose 2025-02-12  110  				return a->mode;
bcbd069b11b024 Shiju Jose 2025-02-12  111  			else
bcbd069b11b024 Shiju Jose 2025-02-12  112  				return 0444;
bcbd069b11b024 Shiju Jose 2025-02-12  113  		}
bcbd069b11b024 Shiju Jose 2025-02-12  114  		break;
bcbd069b11b024 Shiju Jose 2025-02-12  115  	case ECS_RESET:
bcbd069b11b024 Shiju Jose 2025-02-12  116  		if (ops->reset)
bcbd069b11b024 Shiju Jose 2025-02-12  117  			return a->mode;
bcbd069b11b024 Shiju Jose 2025-02-12  118  		break;
bcbd069b11b024 Shiju Jose 2025-02-12  119  	case ECS_THRESHOLD:
bcbd069b11b024 Shiju Jose 2025-02-12  120  		if (ops->get_threshold) {
bcbd069b11b024 Shiju Jose 2025-02-12  121  			if (ops->set_threshold)
bcbd069b11b024 Shiju Jose 2025-02-12  122  				return a->mode;
bcbd069b11b024 Shiju Jose 2025-02-12  123  			else
bcbd069b11b024 Shiju Jose 2025-02-12  124  				return 0444;
bcbd069b11b024 Shiju Jose 2025-02-12  125  		}
bcbd069b11b024 Shiju Jose 2025-02-12  126  		break;
bcbd069b11b024 Shiju Jose 2025-02-12  127  	default:
bcbd069b11b024 Shiju Jose 2025-02-12  128  		break;
bcbd069b11b024 Shiju Jose 2025-02-12  129  	}
bcbd069b11b024 Shiju Jose 2025-02-12  130  
bcbd069b11b024 Shiju Jose 2025-02-12  131  	return 0;
bcbd069b11b024 Shiju Jose 2025-02-12  132  }
bcbd069b11b024 Shiju Jose 2025-02-12  133  
df1b3160633d4f Shiju Jose 2025-06-30  134  static const struct device_attribute ecs_dev_attr[] = {
df1b3160633d4f Shiju Jose 2025-06-30  135  	[ECS_LOG_ENTRY_TYPE]	= __ATTR_RW(log_entry_type),
df1b3160633d4f Shiju Jose 2025-06-30  136  	[ECS_MODE]		= __ATTR_RW(mode),
df1b3160633d4f Shiju Jose 2025-06-30  137  	[ECS_RESET]		= __ATTR_WO(reset),
df1b3160633d4f Shiju Jose 2025-06-30  138  	[ECS_THRESHOLD]		= __ATTR_RW(threshold)
df1b3160633d4f Shiju Jose 2025-06-30  139  };
bcbd069b11b024 Shiju Jose 2025-02-12  140  
bcbd069b11b024 Shiju Jose 2025-02-12  141  static int ecs_create_desc(struct device *ecs_dev, const struct attribute_group **attr_groups,
bcbd069b11b024 Shiju Jose 2025-02-12  142  			   u16 num_media_frus)
bcbd069b11b024 Shiju Jose 2025-02-12  143  {
bcbd069b11b024 Shiju Jose 2025-02-12  144  	struct edac_ecs_context *ecs_ctx;
bcbd069b11b024 Shiju Jose 2025-02-12  145  	u32 fru;
bcbd069b11b024 Shiju Jose 2025-02-12  146  
bcbd069b11b024 Shiju Jose 2025-02-12  147  	ecs_ctx = devm_kzalloc(ecs_dev, sizeof(*ecs_ctx), GFP_KERNEL);
bcbd069b11b024 Shiju Jose 2025-02-12  148  	if (!ecs_ctx)
bcbd069b11b024 Shiju Jose 2025-02-12  149  		return -ENOMEM;
bcbd069b11b024 Shiju Jose 2025-02-12  150  
bcbd069b11b024 Shiju Jose 2025-02-12  151  	ecs_ctx->num_media_frus = num_media_frus;
bcbd069b11b024 Shiju Jose 2025-02-12  152  	ecs_ctx->fru_ctxs = devm_kcalloc(ecs_dev, num_media_frus,
bcbd069b11b024 Shiju Jose 2025-02-12  153  					 sizeof(*ecs_ctx->fru_ctxs),
bcbd069b11b024 Shiju Jose 2025-02-12  154  					 GFP_KERNEL);
bcbd069b11b024 Shiju Jose 2025-02-12  155  	if (!ecs_ctx->fru_ctxs)
bcbd069b11b024 Shiju Jose 2025-02-12  156  		return -ENOMEM;
bcbd069b11b024 Shiju Jose 2025-02-12  157  
bcbd069b11b024 Shiju Jose 2025-02-12  158  	for (fru = 0; fru < num_media_frus; fru++) {
bcbd069b11b024 Shiju Jose 2025-02-12  159  		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
bcbd069b11b024 Shiju Jose 2025-02-12  160  		struct attribute_group *group = &fru_ctx->group;
bcbd069b11b024 Shiju Jose 2025-02-12  161  		int i;
bcbd069b11b024 Shiju Jose 2025-02-12  162  
1e14ea901dc8d9 Shiju Jose 2025-06-26  163  		for (i = 0; i < ECS_MAX_ATTRS; i++) {
df1b3160633d4f Shiju Jose 2025-06-30  164  			fru_ctx->ecs_dev_attr[i].dev_attr = ecs_dev_attr[i];
df1b3160633d4f Shiju Jose 2025-06-30  165  			fru_ctx->ecs_dev_attr[i].fru_id = fru;
df1b3160633d4f Shiju Jose 2025-06-30  166  
1e14ea901dc8d9 Shiju Jose 2025-06-26 @167  			sysfs_attr_init(&fru_ctx->dev_attr[i].dev_attr.attr);
df1b3160633d4f Shiju Jose 2025-06-30  168  			fru_ctx->ecs_attrs[i] = &fru_ctx->ecs_dev_attr[i].dev_attr.attr;
1e14ea901dc8d9 Shiju Jose 2025-06-26  169  		}
bcbd069b11b024 Shiju Jose 2025-02-12  170  
bcbd069b11b024 Shiju Jose 2025-02-12  171  		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
bcbd069b11b024 Shiju Jose 2025-02-12  172  		group->name = fru_ctx->name;
bcbd069b11b024 Shiju Jose 2025-02-12  173  		group->attrs = fru_ctx->ecs_attrs;
bcbd069b11b024 Shiju Jose 2025-02-12  174  		group->is_visible  = ecs_attr_visible;
bcbd069b11b024 Shiju Jose 2025-02-12  175  
bcbd069b11b024 Shiju Jose 2025-02-12  176  		attr_groups[fru] = group;
bcbd069b11b024 Shiju Jose 2025-02-12  177  	}
bcbd069b11b024 Shiju Jose 2025-02-12  178  
bcbd069b11b024 Shiju Jose 2025-02-12  179  	return 0;
bcbd069b11b024 Shiju Jose 2025-02-12  180  }
bcbd069b11b024 Shiju Jose 2025-02-12  181  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

