Return-Path: <linux-edac+bounces-5679-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDGcA6Ghd2kCjQEAu9opvQ
	(envelope-from <linux-edac+bounces-5679-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 26 Jan 2026 18:17:21 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5738B5E5
	for <lists+linux-edac@lfdr.de>; Mon, 26 Jan 2026 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88731300277B
	for <lists+linux-edac@lfdr.de>; Mon, 26 Jan 2026 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C834B42B;
	Mon, 26 Jan 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RuKMGasL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164E34B408;
	Mon, 26 Jan 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447804; cv=none; b=XL72ocQacxf6bu2BELanIAZOZGgdGbHf5oyUdZjjkBJO/FJKboqWI6DMIMVnOnUEHeYT73mxkIPy6QP/a9xaDyhrHPRh0cakQwDatmaQMNnxjyURdrgLIzHRYfOpd9ke5mtj1z+9EH2TXCQYOER5uu/9aDc9Fj2jlWarKgNovZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447804; c=relaxed/simple;
	bh=by31IL0DuWK2HZ0DCYit1nT7P2I/Y7/0K7u870JAWjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU1wpnG4Iwzfi849iPr4l/3uRXZz4iIZXzUEBYOH7L3EDXRPiXbvQwIU/TdpwbKnAxuJ6hG8y5u51gB0lDWsN0YoZR+z9pxQ4TiG9hGxlo/5E6j0fzP4o+bHa4u5vmD46SXKHyAOwiyCxJEbuxOBekVc/20OBEMtCj9/xO3AIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RuKMGasL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C2D3340E02E3;
	Mon, 26 Jan 2026 17:16:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9EJ5gUZIqa4I; Mon, 26 Jan 2026 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769447795; bh=khUSUnSnbB6myn/q+lJ3qUIqPF74VgWoryZZE4KY6qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuKMGasLxzi11hBWCdBfqcHaZLtX+lxmMneLYiEScDzBCp7n9o4LtouTAzHz0ob9n
	 /KFDDqa4SR/nOjJOlzZuJC495QTDqIa2TJMYYcOES6/jbVNmml9rzozXn82JO+VZOQ
	 Rwql0ecYYJgjmZGxgqE/gJxTILyVjbyOMhyHqL27KCFfumRTJdRktyKY1zq4QY4rII
	 PaowL/Jh9awBsWeOX/X6HlXt6BNdmfIsn2g7MJ3LlCffb3XZgk0VQVVYBMmlD8W7kH
	 H7AJ8u+wnxDU0GRxJzBBdJPaxhQespqsi2oT1NsdWRUyhUCxOotIHvOxp9PB+dKznH
	 p2nDbqFfq2ySvFUREie76qfeg4LCiHbmqwde56xrg5qvO1M9x0Lpm77zfm2NUMd7UE
	 xLHEyNv4RXOaj2hizdChOTzdS+2fRiVt15UF0JI70O+DbMBe3AAa7XGpjW44lfbwc7
	 o3iET60Kk/sBB6JXC0aPIUxEGa/EfGHyzDleT1bTEXK+6WvqvGRTifgtc+WW9+314H
	 JX0A9nyJk7Q/VkZuPs670iCoQ+MOP9jOGLhXY9r+CP2yGQQ81NY4VSUaWhpPKp8tdo
	 jf+QZ0F9fkYgDwYQj7eubQVwZNJJySTogA2Ay4z0jZI/XQwC2PExK0e57VoovBFxLi
	 iIEMoQzzJh8o+B4v/dpHNJUY=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9CDF340E01AB;
	Mon, 26 Jan 2026 17:15:58 +0000 (UTC)
Date: Mon, 26 Jan 2026 18:15:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v16 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20260126171552.GJaXehSJp33nFnpvVd@fat_crate.local>
References: <20260123175512.2066-1-shiju.jose@huawei.com>
 <20260123175512.2066-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123175512.2066-2-shiju.jose@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,amperecomputing.com,vger.kernel.org,kvack.org,intel.com,amd.com,huawei.com,google.com,linux.intel.com,nec.com,arm.com,hpe.com,os.amperecomputing.com,gmail.com,hisilicon.com,futurewei.com];
	TAGGED_FROM(0.00)[bounces-5679-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F5738B5E5
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:55:07PM +0000, shiju.jose@huawei.com wrote:
> +static int parse_ras2_table(struct acpi_table_ras2 *ras2_tab)
> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	struct ras2_mem_ctx **pctx_list;
> +	struct ras2_mem_ctx *ras2_ctx;
> +	u16 i;
> +
> +	if (ras2_tab->header.length < sizeof(*ras2_tab)) {
> +		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short, size=%u)\n",
> +			ras2_tab->header.length);
> +		return -EINVAL;
> +	}
> +
> +	if (!ras2_tab->num_pcc_descs || ras2_tab->num_pcc_descs > RAS2_MAX_NUM_PCC_DESCS) {
> +		pr_warn(FW_WARN "No/Invalid number of PCC descs(%d) in ACPI RAS2 table\n",
> +			ras2_tab->num_pcc_descs);
> +		return -EINVAL;
> +	}
> +
> +	pctx_list = kcalloc(ras2_tab->num_pcc_descs, sizeof(*pctx_list), GFP_KERNEL);
> +	if (!pctx_list)
> +		return -ENOMEM;
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +
> +		ras2_ctx = add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_desc_list->channel_id,
> +					  pcc_desc_list->instance);
> +		if (IS_ERR(ras2_ctx)) {
> +			pr_warn("Failed to add RAS2 auxiliary device rc=%ld\n", PTR_ERR(ras2_ctx));
> +			for (; i > 0; i--) {
> +				if (pctx_list[i - 1])
> +					auxiliary_device_uninit(&pctx_list[i - 1]->adev);

This is wrong - there should be a function called remove_aux_device() which
unwinds everything add_aux_device() does for all those devices.

In addition, I did a bunch of cleanups ontop, see below. I can't test them so
pls have a look and run them on your hw and if all good, merge them with your
patch.

Thx.

---

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7f846c22fc30..0010b38e8f81 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -299,9 +299,10 @@ config ACPI_RAS2
 	depends on MAILBOX
 	depends on PCC
 	help
-	  This driver adds support for RAS2 feature table provides interfaces
-	  for platform RAS features, e.g., for HW-based memory scrubbing.
-	  Say 'y/n' to enable/disable ACPI RAS2 support.
+	  Add support for the RAS2 feature table and provide interfaces for
+	  platform RAS features, such as hardware-based memory scrubbing.
+ 
+	  If unsure, select N.
 
 config ACPI_PROCESSOR
 	tristate "Processor"
diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
index a9a9c480ee29..6eed1ada18e1 100644
--- a/drivers/acpi/ras2.c
+++ b/drivers/acpi/ras2.c
@@ -6,10 +6,11 @@
  *
  * Support for RAS2 table - ACPI 6.5 Specification, section 5.2.21, which
  * provides interfaces for platform RAS features, e.g., for HW-based memory
- * scrubbing, and logical to PA translation service. RAS2 uses PCC channel
- * subspace for communicating with the ACPI compliant HW platform.
+ * scrubbing, and logical to physical address translation service. RAS2 uses
+ * PCC channel subspace for communicating with the ACPI compliant HW platform.
  */
 
+#undef pr_fmt
 #define pr_fmt(fmt) "ACPI RAS2: " fmt
 
 #include <linux/delay.h>
@@ -26,13 +27,13 @@
  * @comm_addr:		Pointer to RAS2 PCC shared memory region
  * @pcc_lock:		PCC lock to provide mutually exclusive access
  *			to PCC channel subspace
- * @deadline_us:	Poll PCC status register timeout in micro secs
- *			for PCC command complete
+ * @deadline_us:	Poll PCC status register timeout in microsecs
+ *			for PCC command completion
  * @pcc_mpar:		Maximum Periodic Access Rate (MPAR) for PCC channel
- * @pcc_mrtt:		Minimum Request Turnaround Time (MRTT) in micro secs
+ * @pcc_mrtt:		Minimum Request Turnaround Time (MRTT) in microsecs
  *			OS must wait after completion of a PCC command before
- *			issue next command
- * @last_cmd_cmpl_time:	completion time of last PCC command
+ *			issuing next command
+ * @last_cmd_cmpl_time:	Completion time of last PCC command
  * @last_mpar_reset:	Time of last MPAR count reset
  * @mpar_count:		MPAR count
  * @pcc_id:		Identifier of the RAS2 platform communication channel
@@ -56,63 +57,67 @@ struct ras2_sspcc {
 };
 
 /*
- * Arbitrary retries for PCC commands because the remote processor
- * could be much slower to reply. Keeping it high enough to cover
- * emulators where the processors run painfully slow.
+ * Arbitrary retries for PCC commands because the remote processor could be
+ * much slower to reply. Keep it high enough to cover emulators where the
+ * processors run painfully slow.
  */
 #define PCC_NUM_RETRIES 600ULL
+#define PCC_MIN_POLL_USECS 3
 
 #define RAS2_MAX_NUM_PCC_DESCS 100
 #define RAS2_FEAT_TYPE_MEMORY 0x00
 
-static int decode_cap_error(u32 cap_status)
-{
-	switch (cap_status) {
-	case ACPI_RAS2_NOT_VALID:
-	case ACPI_RAS2_NOT_SUPPORTED:
-		return -EPERM;
-	case ACPI_RAS2_BUSY:
-		return -EBUSY;
-	case ACPI_RAS2_FAILED:
-	case ACPI_RAS2_ABORTED:
-	case ACPI_RAS2_INVALID_DATA:
-		return -EINVAL;
-	default:
-		return 0;
-	}
-}
-
 static int check_pcc_chan(struct ras2_sspcc *sspcc)
 {
 	struct acpi_ras2_shmem __iomem *gen_comm_base = sspcc->comm_addr;
+	u32 cap_status;
 	u16 status;
 	int rc;
 
 	/*
-	 * As per ACPI spec, the PCC space will be initialized by
+	 * As per ACPI spec, the PCC space will be initialized by the
 	 * platform and should have set the command completion bit when
 	 * PCC can be used by OSPM.
 	 *
-	 * Poll PCC status register every 3us for maximum of 600ULL * PCC
-	 * channel latency until PCC command complete bit is set.
+	 * Poll PCC status register every PCC_MIN_POLL_USECS for maximum of
+	 * PCC_NUM_RETRIES * PCC channel latency until PCC command complete
+	 * bit is set.
 	 */
 	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
-					status & PCC_STATUS_CMD_COMPLETE, 3, sspcc->deadline_us);
+					status & PCC_STATUS_CMD_COMPLETE,
+					PCC_MIN_POLL_USECS, sspcc->deadline_us);
 	if (rc) {
-		pr_warn("PCC check channel timeout for last command: 0x%x pcc_id=%d rc=%d\n",
-			 sspcc->last_cmd, sspcc->pcc_id, rc);
+		pr_warn("PCC ID: 0x%x: PCC check channel timeout for last command: 0x%x rc=%d\n",
+		        sspcc->pcc_id, sspcc->last_cmd, rc);
 		return rc;
 	}
 
 	if (status & PCC_STATUS_ERROR) {
-		pr_warn("Error in executing last command: 0x%x for pcc_id=%d\n",
-			sspcc->last_cmd, sspcc->pcc_id);
+		pr_warn("PCC ID: 0x%x: Error in executing last command: 0x%x\n",
+			sspcc->pcc_id, sspcc->last_cmd);
+
 		status &= ~PCC_STATUS_ERROR;
 		writew_relaxed(status, &gen_comm_base->status);
 		return -EIO;
 	}
 
-	rc = decode_cap_error(readw_relaxed(&gen_comm_base->set_caps_status));
+	cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
+	switch (cap_status) {
+	case ACPI_RAS2_NOT_VALID:
+	case ACPI_RAS2_NOT_SUPPORTED:
+		rc = -EPERM;
+		break;
+	case ACPI_RAS2_BUSY:
+		rc = -EBUSY;
+		break;
+	case ACPI_RAS2_FAILED:
+	case ACPI_RAS2_ABORTED:
+	case ACPI_RAS2_INVALID_DATA:
+		rc = -EINVAL;
+		break;
+	default:
+		rc = 0;
+	}
 
 	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
 
@@ -128,15 +133,18 @@ static int check_pcc_chan(struct ras2_sspcc *sspcc)
  */
 int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
 {
-	struct ras2_sspcc *sspcc = ras2_ctx->sspcc;
-	struct acpi_ras2_shmem __iomem *gen_comm_base = sspcc->comm_addr;
+	struct acpi_ras2_shmem __iomem *gen_comm_base;
 	struct mbox_chan *pcc_channel;
+	struct ras2_sspcc *sspcc;
 	unsigned int time_delta;
 	int rc;
 
 	if (!ras2_ctx)
 		return -EINVAL;
 
+	sspcc = ras2_ctx->sspcc;
+	gen_comm_base = sspcc->comm_addr;
+
 	rc = check_pcc_chan(sspcc);
 	if (rc < 0)
 		return rc;
@@ -144,9 +152,9 @@ int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
 	pcc_channel = sspcc->pcc_chan->mchan;
 
 	/*
-	 * Handle the Minimum Request Turnaround Time (MRTT).
-	 * "The minimum amount of time that OSPM must wait after the completion
-	 * of a command before issuing the next command, in microseconds."
+	 * Handle the Minimum Request Turnaround Time (MRTT): the minimum
+	 * amount of time that OSPM must wait after the completion of
+	 * a command before issuing the next command, in microseconds.
 	 */
 	if (sspcc->pcc_mrtt) {
 		time_delta = ktime_us_delta(ktime_get(), sspcc->last_cmd_cmpl_time);
@@ -155,24 +163,26 @@ int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
 	}
 
 	/*
-	 * Handle the non-zero Maximum Periodic Access Rate (MPAR).
-	 * "The maximum number of periodic requests that the subspace channel can
-	 * support, reported in commands per minute. 0 indicates no limitation."
+	 * Handle the non-zero Maximum Periodic Access Rate (MPAR): the
+	 * maximum number of periodic requests that the subspace channel can
+	 * support, reported in commands per minute. 0 indicates no
+	 * limitation.
 	 *
-	 * This parameter should be ideally zero or large enough so that it can
-	 * handle maximum number of requests that all the cores in the system can
-	 * collectively generate. If it is not, follow the spec and just not
-	 * send the request to the platform after hitting the MPAR limit in
-	 * any 60s window.
+	 * This parameter should be ideally zero or large enough so that it
+	 * can handle maximum number of requests that all the cores in the
+	 * system can collectively generate. If it is not, follow the spec and
+	 * just not send the request to the platform after hitting the MPAR
+	 * limit in any 60s window.
 	 */
 	if (sspcc->pcc_mpar) {
 		if (!sspcc->mpar_count) {
 			time_delta = ktime_ms_delta(ktime_get(), sspcc->last_mpar_reset);
 			if (time_delta < 60 * MSEC_PER_SEC) {
 				dev_dbg(ras2_ctx->dev,
-					"PCC command: 0x%x not sent due to MPAR limit", cmd);
+					"PCC command 0x%x not sent due to MPAR limit", cmd);
 				return -EIO;
 			}
+
 			sspcc->last_mpar_reset = ktime_get();
 			sspcc->mpar_count = sspcc->pcc_mpar;
 		}
@@ -187,22 +197,24 @@ int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
 
 	/* Ring doorbell */
 	rc = mbox_send_message(pcc_channel, &cmd);
+
 	/*
-	 * mbox_send_message() return non-negative integer for successful submission
-	 * and negative value on failure.
+	 * mbox_send_message() returns a non-negative integer for successful submission
+	 * and a negative value on failure.
 	 */
-	rc = rc < 0 ? rc : 0;
 	if (rc < 0) {
 		dev_warn(ras2_ctx->dev,
 			 "Error sending PCC mbox message command: 0x%x, rc:%d\n", cmd, rc);
 		return rc;
+	} else {
+		rc = 0;
 	}
 
 	sspcc->last_cmd = cmd;
 
 	/*
 	 * If Minimum Request Turnaround Time is non-zero, need to record the
-	 * completion time of both READ and WRITE command for proper handling
+	 * completion time of both READ and WRITE commands for proper handling
 	 * of MRTT, so need to check for pcc_mrtt in addition to PCC_CMD_EXEC_RAS2.
 	 */
 	if (cmd == PCC_CMD_EXEC_RAS2 || sspcc->pcc_mrtt) {
@@ -222,7 +234,7 @@ int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
+EXPORT_SYMBOL_FOR_MODULES(ras2_send_pcc_cmd, "acpi_ras2");
 
 static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
 {
@@ -283,18 +295,20 @@ static struct ras2_mem_ctx *add_aux_device(char *name, int channel, u32 pxm_inst
 {
 	struct ras2_mem_ctx *ras2_ctx;
 	struct ras2_sspcc *sspcc;
+	u32 comp_nid;
 	int id, rc;
 
+	comp_nid = pxm_to_node(pxm_inst);
+	if (comp_nid == NUMA_NO_NODE) {
+		pr_debug("Invalid NUMA node, channel=%d pxm_inst=%d\n", channel, pxm_inst);
+		return ERR_PTR(-EINVAL);
+	}
+
 	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
 	if (!ras2_ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ras2_ctx->sys_comp_nid = pxm_to_node(pxm_inst);
-	if (ras2_ctx->sys_comp_nid == NUMA_NO_NODE) {
-		pr_debug("Invalid NUMA node, channel=%d pxm_inst=%d\n", channel, pxm_inst);
-		rc = -EINVAL;
-		goto ctx_free;
-	}
+	ras2_ctx->sys_comp_nid = comp_nid;
 
 	rc = register_pcc_channel(ras2_ctx, channel);
 	if (rc < 0) {
@@ -321,7 +335,7 @@ static struct ras2_mem_ctx *add_aux_device(char *name, int channel, u32 pxm_inst
 	rc = auxiliary_device_add(&ras2_ctx->adev);
 	if (rc) {
 		auxiliary_device_uninit(&ras2_ctx->adev);
-		return ERR_PTR(rc);
+		goto ida_free;
 	}
 
 	return ras2_ctx;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

