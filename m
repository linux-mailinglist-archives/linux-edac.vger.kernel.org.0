Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9510990D
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 07:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKZGHZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 01:07:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfKZGHY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Nov 2019 01:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YRJmUXAFOl5t0i6sel1LYEP7UHa15IRT/rQV3kSVKv0=; b=eJbNA9MO0wKNIrcp3jpFaItNw
        GAgrGiqn840RXXMKM0PU+OvfuzAuFFdOOXvVzCj4Uuxvfbkcu3bdzU17eLaxUI812QyXY8XhKNE0y
        s5m5nLqqvf6Xrrqby9+hqL3KG1CooIqED3DXGoVmGIRXUzxjxMOMck8oTqpu/b3dF5Y90s8kOqm3g
        NjHhSCvAG2oVHT4OggL4iYlCfQRu6kYTbqgu1tDH7G8XD/FcjulcspAkZRvdbopZXdcal1STKIWJX
        ig5+fOMxX96mvB+Sm1C4gtjE+JhvJ+HxNsnRI1P7ExzgH292AHTd4G+fRqkWQv82L6cmMy04VZkjk
        Zt6QWZ/EA==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZU0O-00061J-OD; Tue, 26 Nov 2019 06:07:20 +0000
Date:   Tue, 26 Nov 2019 07:07:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 3/9] rasdaemon: decode submodule of OEM type1 for hip08
Message-ID: <20191126070713.5bc61802@kernel.org>
In-Reply-To: <1573561634-225173-4-git-send-email-tanxiaofei@huawei.com>
References: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
        <1573561634-225173-4-git-send-email-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Tue, 12 Nov 2019 20:27:08 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

> Decode submodule of OEM type1 for hip08, and reconstruct the functions
> of geting OEM module name and submodule name.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  non-standard-hisi_hip08.c | 286 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 221 insertions(+), 65 deletions(-)
> 
> diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
> index 5e4b6a0..afdd649 100644
> --- a/non-standard-hisi_hip08.c
> +++ b/non-standard-hisi_hip08.c
> @@ -182,6 +182,13 @@ enum {
>  	hip08_pcie_local_field_regs_dump,
>  };
>  
> +struct hisi_module_info {
> +	int id;
> +	const char *name;
> +	const char **sub;
> +	int sub_num;
> +};
> +
>  /* helper functions */
>  static char *err_severity(uint8_t err_sev)
>  {
> @@ -194,37 +201,137 @@ static char *err_severity(uint8_t err_sev)
>  	return "unknown";
>  }
>  
> -static char *oem_type1_module_name(uint8_t module_id)
> -{
> -	switch (module_id) {
> -	case HISI_OEM_MODULE_ID_MN: return "MN";
> -	case HISI_OEM_MODULE_ID_PLL: return "PLL";
> -	case HISI_OEM_MODULE_ID_SLLC: return "SLLC";
> -	case HISI_OEM_MODULE_ID_AA: return "AA";
> -	case HISI_OEM_MODULE_ID_SIOE: return "SIOE";
> -	case HISI_OEM_MODULE_ID_POE: return "POE";
> -	case HISI_OEM_MODULE_ID_DISP: return "DISP";
> -	case HISI_OEM_MODULE_ID_LPC: return "LPC";
> -	case HISI_OEM_MODULE_ID_GIC: return "GIC";
> -	case HISI_OEM_MODULE_ID_RDE: return "RDE";
> -	case HISI_OEM_MODULE_ID_SAS: return "SAS";
> -	case HISI_OEM_MODULE_ID_SATA: return "SATA";
> -	case HISI_OEM_MODULE_ID_USB: return "USB";
> -	}
> -	return "unknown";
> -}
> +static const char *pll_submodule_name[] = {
> +	"TB_PLL0",
> +	"TB_PLL1",
> +	"TB_PLL2",
> +	"TB_PLL3",
> +	"TA_PLL0",
> +	"TA_PLL1",
> +	"TA_PLL2",
> +	"TA_PLL3",
> +	"NIMBUS_PLL0",
> +	"NIMBUS_PLL1",
> +	"NIMBUS_PLL2",
> +	"NIMBUS_PLL3",
> +	"NIMBUS_PLL4",
> +};
>  
> -static char *oem_type2_module_name(uint8_t module_id)
> -{
> -	switch (module_id) {
> -	case HISI_OEM_MODULE_ID_SMMU: return "SMMU";
> -	case HISI_OEM_MODULE_ID_HHA: return "HHA";
> -	case HISI_OEM_MODULE_ID_HLLC: return "HLLC";
> -	case HISI_OEM_MODULE_ID_PA: return "PA";
> -	case HISI_OEM_MODULE_ID_DDRC: return "DDRC";
> -	}
> -	return "unknown module";
> -}
> +static const char *sllc_submodule_name[] = {
> +	"TB_SLLC0",
> +	"TB_SLLC1",
> +	"TB_SLLC2",
> +	"TA_SLLC0",
> +	"TA_SLLC1",
> +	"TA_SLLC2",
> +	"NIMBUS_SLLC0",
> +	"NIMBUS_SLLC1",
> +};
> +
> +static const char *sioe_submodule_name[] = {
> +	"TB_SIOE0",
> +	"TB_SIOE1",
> +	"TB_SIOE2",
> +	"TB_SIOE3",
> +	"TA_SIOE0",
> +	"TA_SIOE1",
> +	"TA_SIOE2",
> +	"TA_SIOE3",
> +	"NIMBUS_SIOE0",
> +	"NIMBUS_SIOE1",
> +};
> +
> +static const char *poe_submodule_name[] = {
> +	"TB_POE",
> +	"TA_POE",
> +};
> +
> +static const char *disp_submodule_name[] = {
> +	"TB_PERI_DISP",
> +	"TB_POE_DISP",
> +	"TB_GIC_DISP",
> +	"TA_PERI_DISP",
> +	"TA_POE_DISP",
> +	"TA_GIC_DISP",
> +	"HAC_DISP",
> +	"PCIE_DISP",
> +	"IO_MGMT_DISP",
> +	"NETWORK_DISP",
> +};
> +
> +static const char *sas_submodule_name[] = {
> +	"SAS0",
> +	"SAS1",
> +};
> +
> +static const struct hisi_module_info hisi_oem_type1_module[] = {
> +	{
> +		.id = HISI_OEM_MODULE_ID_PLL,
> +		.name = "PLL",
> +		.sub = pll_submodule_name,
> +		.sub_num = ARRAY_SIZE(pll_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_SAS,
> +		.name = "SAS",
> +		.sub = sas_submodule_name,
> +		.sub_num = ARRAY_SIZE(sas_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_POE,
> +		.name = "POE",
> +		.sub = poe_submodule_name,
> +		.sub_num = ARRAY_SIZE(poe_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_SLLC,
> +		.name = "SLLC",
> +		.sub = sllc_submodule_name,
> +		.sub_num = ARRAY_SIZE(sllc_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_SIOE,
> +		.name = "SIOE",
> +		.sub = sioe_submodule_name,
> +		.sub_num = ARRAY_SIZE(sioe_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_DISP,
> +		.name = "DISP",
> +		.sub = disp_submodule_name,
> +		.sub_num = ARRAY_SIZE(disp_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_MN,
> +		.name = "MN",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_AA,
> +		.name = "AA",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_LPC,
> +		.name = "LPC",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_GIC,
> +		.name = "GIC",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_RDE,
> +		.name = "RDE",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_SATA,
> +		.name = "SATA",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_USB,
> +		.name = "USB",
> +	},
> +	{
> +	}
> +};
>  
>  static const char *smmu_submodule_name[] = {
>  	"HAC_SMMU",
> @@ -257,27 +364,72 @@ static const char *ddrc_submodule_name[] = {
>  	"TB_DDRC3",
>  };
>  
> -static const char *oem_type2_sub_module_name(uint8_t module_id, uint8_t sub_module_id)
> +static const struct hisi_module_info hisi_oem_type2_module[] = {
> +	{
> +		.id = HISI_OEM_MODULE_ID_SMMU,
> +		.name = "SMMU",
> +		.sub = smmu_submodule_name,
> +		.sub_num = ARRAY_SIZE(smmu_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_HHA,
> +		.name = "HHA",
> +		.sub = hha_submodule_name,
> +		.sub_num = ARRAY_SIZE(hha_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_PA,
> +		.name = "PA",
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_HLLC,
> +		.name = "HLLC",
> +		.sub = hllc_submodule_name,
> +		.sub_num = ARRAY_SIZE(hllc_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_DDRC,
> +		.name = "DDRC",
> +		.sub = ddrc_submodule_name,
> +		.sub_num = ARRAY_SIZE(ddrc_submodule_name),
> +	},
> +	{
> +	}
> +};
> +
> +static const char *oem_module_name(const struct hisi_module_info *info,
> +				   uint8_t module_id)
>  {
> -	switch (module_id) {
> -	case HISI_OEM_MODULE_ID_SMMU:
> -		if (sub_module_id < sizeof(smmu_submodule_name)/sizeof(char *))
> -			return smmu_submodule_name[sub_module_id];
> -		break;
> -	case HISI_OEM_MODULE_ID_HLLC:
> -		if (sub_module_id < sizeof(hllc_submodule_name)/sizeof(char *))
> -			return hllc_submodule_name[sub_module_id];
> -		break;
> -	case HISI_OEM_MODULE_ID_PA:
> -		return "PA";
> -	case HISI_OEM_MODULE_ID_HHA:
> -		if (sub_module_id < sizeof(hha_submodule_name)/sizeof(char *))
> -			return hha_submodule_name[sub_module_id];
> -		break;
> -	case HISI_OEM_MODULE_ID_DDRC:
> -		if (sub_module_id < sizeof(ddrc_submodule_name)/sizeof(char *))
> -			return ddrc_submodule_name[sub_module_id];
> -		break;
> +	const struct hisi_module_info *module = &info[0];
> +
> +	for (; module->name; module++) {
> +		if (module->id != module_id)
> +			continue;
> +
> +		return module->name;
> +	}
> +
> +	return "unknown";
> +}
> +
> +static const char *oem_submodule_name(const struct hisi_module_info *info,
> +				      uint8_t module_id, uint8_t sub_module_id)
> +{
> +	const struct hisi_module_info *module = &info[0];
> +
> +	for (; module->name; module++) {
> +		const char **submodule = module->sub;
> +
> +		if (module->id != module_id)
> +			continue;
> +
> +		if (module->sub == NULL)
> +			return module->name;
> +
> +		if (sub_module_id >= module->sub_num)
> +			return "unknown";
> +
> +		return submodule[sub_module_id];
>  	}
>  
>  	return "unknown";
> @@ -467,23 +619,24 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
>  	}
>  
>  	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
> -		p += sprintf(p, "module=%s ",
> -			     oem_type1_module_name(err->module_id));
> +		const char *str = oem_module_name(hisi_oem_type1_module,
> +						  err->module_id);
> +
> +		p += snprintf(p, end - p, "module=%s ", str);



Rasdaemon doesn't build after applying this patch, as "end" doesn't exist
yet.

I suspect that a latter patch in this series could be adding it, but
the better is to not break rasdaemon build on some random patch, as, if
we ever need to do a git bisect, this would make it harder for it to
work.


>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>  				   hip08_oem_type1_field_module_id,
> -				   0, oem_type1_module_name(err->module_id));
> +				   0, str);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
> -		char submodule_name[64];
> +		const char *str = oem_submodule_name(hisi_oem_type1_module,
> +						     err->module_id,
> +						     err->sub_module_id);
>  
> -		sprintf(submodule_name, "%s%d",
> -			oem_type1_module_name(err->module_id),
> -			err->sub_module_id);
> -		p += sprintf(p, "submodule=%s ", submodule_name);
> +		p += snprintf(p, end - p, "submodule=%s ", str);
>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>  				   hip08_oem_type1_field_sub_module_id,
> -				   0, submodule_name);
> +				   0, str);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
> @@ -596,18 +749,21 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
>  	}
>  
>  	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
> -		p += sprintf(p, "module=%s ",
> -			     oem_type2_module_name(err->module_id));
> +		const char *str = oem_module_name(hisi_oem_type2_module,
> +						  err->module_id);
> +
> +		p += snprintf(p, end - p, "module=%s ", str);
>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>  				   hip08_oem_type2_field_module_id,
> -				   0, oem_type2_module_name(err->module_id));
> +				   0, str);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
> -		const char *str = oem_type2_sub_module_name(err->module_id,
> -							    err->sub_module_id);
> +		const char *str = oem_submodule_name(hisi_oem_type2_module,
> +						     err->module_id,
> +						     err->sub_module_id);
>  
> -		p += sprintf(p, "submodule=%s ", str);
> +		p += snprintf(p, end - p, "submodule=%s ", str);
>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>  				   hip08_oem_type2_field_sub_module_id,
>  				   0, str);




Cheers,
Mauro
