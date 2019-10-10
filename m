Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD6D2FA7
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfJJRev (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 13:34:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJRev (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 13:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZOOoznYxVRyKDZRsz6pKwkGxpdlbXVOxE33r5Dx8pKI=; b=cZxCQI/bZksVcBhxwEfp4UsXT
        q1kin0ZewDu2FwqVTrqVyQcABd4Po51GSUV7AXGEKELopQpnsyQCOVM0Vc4s7zvVODG55JPQ2GU7+
        uG6uU3Y89qQ2SX48DBv8QmpTMC1qy2QS7uCcML96u7MoEVD5O0NI6NGZWEn88y93ssCMM6UesEz3Z
        nOCFsm8CnjMIGasUwbD1ityaWT1pl4hvM/g0N9p6BHkYGDNwEjLUSm7qg2PHLu4ym31gDQJsKy8Ri
        ORuQ7SD/RKi0n5eNKlyn+z3qhWvwTJuWf3lTGSRJgnwi8S6e2+9XNKSMGiUe0tppEfJ3UeahFRDJA
        TMnO1Gu6Q==;
Received: from 177.205.100.4.dynamic.adsl.gvt.net.br ([177.205.100.4] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIcKw-0006xD-WE; Thu, 10 Oct 2019 17:34:51 +0000
Date:   Thu, 10 Oct 2019 14:34:46 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 1/5] rasdaemon: optimize sqlite3 DB record of register
 fields for hip08
Message-ID: <20191010143446.795e5136@coco.lan>
In-Reply-To: <1570538338-230884-2-git-send-email-tanxiaofei@huawei.com>
References: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
        <1570538338-230884-2-git-send-email-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Tue, 8 Oct 2019 20:38:54 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

> Optimize sqlite3 DB record of register fields for hip08 by combining
> all register fields to one text field, which will include register name.
> This will make the record easier to read.

Patch series applied, thanks!

Regards,
Mauro
> 
> For example, from:
> INSERT INTO hip08_oem_type2_event VALUES(1,1,1,0,0,'SMMU',2,'corrected',
> 273058,0,-1,0,1308622858,0,0,0,0,133,0,0,NULL);
> 
> change to:
> INSERT INTO hip08_oem_type2_event VALUES(1,1,1,0,0,'SMMU',2,'corrected',
> 'ERR_FR_0=0x42aa2 ERR_FR_1=0x0 ERR_CTRL_0=0xffffffff ERR_CTRL_1=0x0
> ERR_STATUS_0=0x4e00000a ERR_STATUS_1=0x0 ERR_ADDR_0=0x0, ERR_ADDR_1=0x0
> ERR_MISC0_0=0x0 ERR_MISC0_1=0x90 ERR_MISC1_0=0x0 ERR_MISC1_1=0x0');
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  non-standard-hisi_hip08.c | 167 +++++++++++-----------------------------------
>  1 file changed, 40 insertions(+), 127 deletions(-)
> 
> diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
> index ae543d6..393053d 100644
> --- a/non-standard-hisi_hip08.c
> +++ b/non-standard-hisi_hip08.c
> @@ -147,12 +147,7 @@ enum {
>  	hip08_oem_type1_field_module_id,
>  	hip08_oem_type1_field_sub_module_id,
>  	hip08_oem_type1_field_err_sev,
> -	hip08_oem_type1_field_err_misc_0,
> -	hip08_oem_type1_field_err_misc_1,
> -	hip08_oem_type1_field_err_misc_2,
> -	hip08_oem_type1_field_err_misc_3,
> -	hip08_oem_type1_field_err_misc_4,
> -	hip08_oem_type1_field_err_addr,
> +	hip08_oem_type1_field_regs_dump,
>  };
>  
>  enum {
> @@ -164,18 +159,7 @@ enum {
>  	hip08_oem_type2_field_module_id,
>  	hip08_oem_type2_field_sub_module_id,
>  	hip08_oem_type2_field_err_sev,
> -	hip08_oem_type2_field_err_fr_0,
> -	hip08_oem_type2_field_err_fr_1,
> -	hip08_oem_type2_field_err_ctrl_0,
> -	hip08_oem_type2_field_err_ctrl_1,
> -	hip08_oem_type2_field_err_status_0,
> -	hip08_oem_type2_field_err_status_1,
> -	hip08_oem_type2_field_err_addr_0,
> -	hip08_oem_type2_field_err_addr_1,
> -	hip08_oem_type2_field_err_misc0_0,
> -	hip08_oem_type2_field_err_misc0_1,
> -	hip08_oem_type2_field_err_misc1_0,
> -	hip08_oem_type2_field_err_misc1_1,
> +	hip08_oem_type2_field_regs_dump,
>  };
>  
>  enum {
> @@ -189,7 +173,7 @@ enum {
>  	hip08_pcie_local_field_port_id,
>  	hip08_pcie_local_field_err_sev,
>  	hip08_pcie_local_field_err_type,
> -	hip08_pcie_local_field_err_misc,
> +	hip08_pcie_local_field_regs_dump,
>  };
>  
>  /* helper functions */
> @@ -299,12 +283,7 @@ static const struct db_fields hip08_oem_type1_event_fields[] = {
>  	{ .name = "module_id",		.type = "TEXT" },
>  	{ .name = "sub_module_id",	.type = "INTEGER" },
>  	{ .name = "err_severity",	.type = "TEXT" },
> -	{ .name = "err_misc_0",		.type = "INTEGER" },
> -	{ .name = "err_misc_1",		.type = "INTEGER" },
> -	{ .name = "err_misc_2",		.type = "INTEGER" },
> -	{ .name = "err_misc_3",		.type = "INTEGER" },
> -	{ .name = "err_misc_4",		.type = "INTEGER" },
> -	{ .name = "err_addr",		.type = "INTEGER" },
> +	{ .name = "regs_dump",		.type = "TEXT" },
>  };
>  
>  static const struct db_table_descriptor hip08_oem_type1_event_tab = {
> @@ -322,18 +301,7 @@ static const struct db_fields hip08_oem_type2_event_fields[] = {
>  	{ .name = "module_id",          .type = "TEXT" },
>  	{ .name = "sub_module_id",      .type = "INTEGER" },
>  	{ .name = "err_severity",       .type = "TEXT" },
> -	{ .name = "err_fr_0",		.type = "INTEGER" },
> -	{ .name = "err_fr_1",		.type = "INTEGER" },
> -	{ .name = "err_ctrl_0",		.type = "INTEGER" },
> -	{ .name = "err_ctrl_1",		.type = "INTEGER" },
> -	{ .name = "err_status_0",	.type = "INTEGER" },
> -	{ .name = "err_status_1",	.type = "INTEGER" },
> -	{ .name = "err_addr_0",         .type = "INTEGER" },
> -	{ .name = "err_addr_1",         .type = "INTEGER" },
> -	{ .name = "err_misc0_0",	.type = "INTEGER" },
> -	{ .name = "err_misc0_1",	.type = "INTEGER" },
> -	{ .name = "err_misc1_0",	.type = "INTEGER" },
> -	{ .name = "err_misc1_1",	.type = "INTEGER" },
> +	{ .name = "regs_dump",		.type = "TEXT" },
>  };
>  
>  static const struct db_table_descriptor hip08_oem_type2_event_tab = {
> @@ -353,39 +321,7 @@ static const struct db_fields hip08_pcie_local_event_fields[] = {
>  	{ .name = "port_id",		.type = "INTEGER" },
>  	{ .name = "err_severity",       .type = "TEXT" },
>  	{ .name = "err_type",		.type = "INTEGER" },
> -	{ .name = "err_misc0",		.type = "INTEGER" },
> -	{ .name = "err_misc1",		.type = "INTEGER" },
> -	{ .name = "err_misc2",		.type = "INTEGER" },
> -	{ .name = "err_misc3",		.type = "INTEGER" },
> -	{ .name = "err_misc4",		.type = "INTEGER" },
> -	{ .name = "err_misc5",		.type = "INTEGER" },
> -	{ .name = "err_misc6",		.type = "INTEGER" },
> -	{ .name = "err_misc7",		.type = "INTEGER" },
> -	{ .name = "err_misc8",		.type = "INTEGER" },
> -	{ .name = "err_misc9",		.type = "INTEGER" },
> -	{ .name = "err_misc10",		.type = "INTEGER" },
> -	{ .name = "err_misc11",		.type = "INTEGER" },
> -	{ .name = "err_misc12",		.type = "INTEGER" },
> -	{ .name = "err_misc13",		.type = "INTEGER" },
> -	{ .name = "err_misc14",		.type = "INTEGER" },
> -	{ .name = "err_misc15",		.type = "INTEGER" },
> -	{ .name = "err_misc16",		.type = "INTEGER" },
> -	{ .name = "err_misc17",		.type = "INTEGER" },
> -	{ .name = "err_misc18",		.type = "INTEGER" },
> -	{ .name = "err_misc19",		.type = "INTEGER" },
> -	{ .name = "err_misc20",		.type = "INTEGER" },
> -	{ .name = "err_misc21",		.type = "INTEGER" },
> -	{ .name = "err_misc22",		.type = "INTEGER" },
> -	{ .name = "err_misc23",		.type = "INTEGER" },
> -	{ .name = "err_misc24",		.type = "INTEGER" },
> -	{ .name = "err_misc25",		.type = "INTEGER" },
> -	{ .name = "err_misc26",		.type = "INTEGER" },
> -	{ .name = "err_misc27",		.type = "INTEGER" },
> -	{ .name = "err_misc28",		.type = "INTEGER" },
> -	{ .name = "err_misc29",		.type = "INTEGER" },
> -	{ .name = "err_misc30",		.type = "INTEGER" },
> -	{ .name = "err_misc31",		.type = "INTEGER" },
> -	{ .name = "err_misc32",		.type = "INTEGER" },
> +	{ .name = "regs_dump",		.type = "TEXT" },
>  };
>  
>  static const struct db_table_descriptor hip08_pcie_local_event_tab = {
> @@ -526,49 +462,42 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
>  	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
>  	trace_seq_printf(s, "%s\n", buf);
>  
> +	p = buf;
>  	trace_seq_printf(s, "Reg Dump:\n");
>  	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_0) {
>  		trace_seq_printf(s, "ERR_MISC0=0x%x\n", err->err_misc_0);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type1_field_err_misc_0,
> -				   err->err_misc_0, NULL);
> +		p += sprintf(p, "ERR_MISC0=0x%x ", err->err_misc_0);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_1) {
>  		trace_seq_printf(s, "ERR_MISC1=0x%x\n", err->err_misc_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type1_field_err_misc_1,
> -				   err->err_misc_1, NULL);
> +		p += sprintf(p, "ERR_MISC1=0x%x ", err->err_misc_1);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_2) {
>  		trace_seq_printf(s, "ERR_MISC2=0x%x\n", err->err_misc_2);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type1_field_err_misc_2,
> -				   err->err_misc_2, NULL);
> +		p += sprintf(p, "ERR_MISC2=0x%x ", err->err_misc_2);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_3) {
>  		trace_seq_printf(s, "ERR_MISC3=0x%x\n", err->err_misc_3);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type1_field_err_misc_3,
> -				   err->err_misc_3, NULL);
> +		p += sprintf(p, "ERR_MISC3=0x%x ", err->err_misc_3);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_4) {
>  		trace_seq_printf(s, "ERR_MISC4=0x%x\n", err->err_misc_4);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type1_field_err_misc_4,
> -				   err->err_misc_4, NULL);
> +		p += sprintf(p, "ERR_MISC4=0x%x ", err->err_misc_4);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_ADDR) {
>  		trace_seq_printf(s, "ERR_ADDR=0x%p\n", (void *)err->err_addr);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int64,
> -				   hip08_oem_type1_field_err_addr,
> -				   err->err_addr, NULL);
> +		p += sprintf(p, "ERR_ADDR=0x%p ", (void *)err->err_addr);
>  	}
>  
> +	*(--p) = '\0';
> +	record_vendor_data(dec_tab, hisi_oem_data_type_text,
> +			   hip08_oem_type1_field_regs_dump, 0, buf);
> +
>  	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
>  
>  	return 0;
> @@ -652,73 +581,54 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
>  	trace_seq_printf(s, "\nHISI HIP08: OEM Type-2 Error\n");
>  	trace_seq_printf(s, "%s\n", buf);
>  
> +	p = buf;
>  	trace_seq_printf(s, "Reg Dump:\n");
>  	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_FR) {
>  		trace_seq_printf(s, "ERR_FR_0=0x%x\n", err->err_fr_0);
>  		trace_seq_printf(s, "ERR_FR_1=0x%x\n", err->err_fr_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_fr_0,
> -				   err->err_fr_0, NULL);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_fr_1,
> -				   err->err_fr_1, NULL);
> +		p += sprintf(p, "ERR_FR_0=0x%x ERR_FR_1=0x%x ",
> +			     err->err_fr_0, err->err_fr_1);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_CTRL) {
>  		trace_seq_printf(s, "ERR_CTRL_0=0x%x\n", err->err_ctrl_0);
>  		trace_seq_printf(s, "ERR_CTRL_1=0x%x\n", err->err_ctrl_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_ctrl_0,
> -				   err->err_ctrl_0, NULL);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_ctrl_1,
> -				   err->err_ctrl_1, NULL);
> +		p += sprintf(p, "ERR_CTRL_0=0x%x ERR_CTRL_1=0x%x ",
> +				err->err_ctrl_0, err->err_ctrl_1);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_STATUS) {
>  		trace_seq_printf(s, "ERR_STATUS_0=0x%x\n", err->err_status_0);
>  		trace_seq_printf(s, "ERR_STATUS_1=0x%x\n", err->err_status_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_status_0,
> -				   err->err_status_0, NULL);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_status_1,
> -				   err->err_status_1, NULL);
> +		p += sprintf(p, "ERR_STATUS_0=0x%x ERR_STATUS_1=0x%x ",
> +			     err->err_status_0, err->err_status_1);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_ADDR) {
>  		trace_seq_printf(s, "ERR_ADDR_0=0x%x\n", err->err_addr_0);
>  		trace_seq_printf(s, "ERR_ADDR_1=0x%x\n", err->err_addr_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_addr_0,
> -				   err->err_addr_0, NULL);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_addr_1,
> -				   err->err_addr_1, NULL);
> +		p += sprintf(p, "ERR_ADDR_0=0x%x ERR_ADDR_1=0x%x ",
> +			     err->err_addr_0, err->err_addr_1);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_0) {
>  		trace_seq_printf(s, "ERR_MISC0_0=0x%x\n", err->err_misc0_0);
>  		trace_seq_printf(s, "ERR_MISC0_1=0x%x\n", err->err_misc0_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_misc0_0,
> -				   err->err_misc0_0, NULL);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_misc0_1,
> -				   err->err_misc0_1, NULL);
> +		p += sprintf(p, "ERR_MISC0_0=0x%x ERR_MISC0_1=0x%x ",
> +			     err->err_misc0_0, err->err_misc0_1);
>  	}
>  
>  	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_1) {
>  		trace_seq_printf(s, "ERR_MISC1_0=0x%x\n", err->err_misc1_0);
>  		trace_seq_printf(s, "ERR_MISC1_1=0x%x\n", err->err_misc1_1);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_misc1_0,
> -				   err->err_misc1_0, NULL);
> -		record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -				   hip08_oem_type2_field_err_misc1_1,
> -				   err->err_misc1_1, NULL);
> +		p += sprintf(p, "ERR_MISC1_0=0x%x ERR_MISC1_1=0x%x ",
> +			     err->err_misc1_0, err->err_misc1_1);
>  	}
>  
> +	*(--p) = '\0';
> +	record_vendor_data(dec_tab, hisi_oem_data_type_text,
> +			   hip08_oem_type2_field_regs_dump, 0, buf);
> +
>  	step_vendor_data_tab(dec_tab, "hip08_oem_type2_event_tab");
>  
>  	return 0;
> @@ -816,17 +726,20 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
>  	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
>  	trace_seq_printf(s, "%s\n", buf);
>  
> +	p = buf;
>  	trace_seq_printf(s, "Reg Dump:\n");
>  	for (i = 0; i < 33; i++) {
>  		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i)) {
>  			trace_seq_printf(s, "ERR_MISC_%d=0x%x\n", i,
>  					 err->err_misc[i]);
> -			record_vendor_data(dec_tab, hisi_oem_data_type_int,
> -					   (hip08_pcie_local_field_err_misc + i),
> -					   err->err_misc[i], NULL);
> +			p += sprintf(p, "ERR_MISC_%d=0x%x ", i, err->err_misc[i]);
>  		}
>  	}
>  
> +	*(--p) = '\0';
> +	record_vendor_data(dec_tab, hisi_oem_data_type_text,
> +			   hip08_pcie_local_field_regs_dump, 0, buf);
> +
>  	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
>  
>  	return 0;



Thanks,
Mauro
