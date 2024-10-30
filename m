Return-Path: <linux-edac+bounces-2345-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D19B642A
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CE72820C8
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4D1E47BC;
	Wed, 30 Oct 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kQk9UYHB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455F3FB31;
	Wed, 30 Oct 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295177; cv=none; b=b3Gyyajsyn1EtS2ZsT6FWqH4+vcFYLCn+xy+PStnkljRqT2o2JfTItXC+vqYrdXNIAuIM0C+fTGL8HdVXF8sUb6A37+12BbLo1/MqvGp3kB1Fd8TfTcQ/HwidNz+uPDOkHZIEhypWbXhV8f86IUMqv8gJ1NR0j7Kwm3K4na5Qtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295177; c=relaxed/simple;
	bh=JuJGGbUyMfw/WGeLkAnhDnD/P9fXPIrb7LuOlDybwzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJcOEpWEgtqw3O2xmdLS0BPhdedkYrZpgKnGiV0rfUAtvW1ajajXQzuAPIJf4YY2vU3DU7m6Ttxzqv7pqNHlDo2DH5GRp2nP5Qq7Vqo6iFvnV/lBJd1eWtDGlFmDM3XyuzTitcUSHuGriCJlRuCqla6GnXt54+n9dLu1t0goUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kQk9UYHB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20CBA40E0191;
	Wed, 30 Oct 2024 13:32:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1k9kVbCppEif; Wed, 30 Oct 2024 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730295166; bh=uisbDX9mYhfxWZr7rzArxjasxG+HKkFeR2Cbs8jZP4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQk9UYHBBlGORP2bFWpYk15SniW7fkrukGEhBEUcCcM6yaUeRsarxslwrlPa7/6Xo
	 3ZrSd4YF40hdWgNwPxS/7ZmQ5DIGK69AP2FvvbI1NKvz74SJxeUKWXBqBQQnfCfO26
	 Jh1cCn8tn5aDWP2VUNInYw6MYGWX/BhuA1CI+q+IMSZ4Itgp9EK58E0gMYD9bcqvRw
	 +koejIV3t5jWXvdQSXVpGqsdvStfzljhfslGr7ACUqQm1QTwmGKb4PfU6QP4RhbdEY
	 hob+bBqbEJWkyKEVzHaZtUQFoXeGznflNnW1IJE/cKWQnQNWd2Z4UgFecurgpNH0FW
	 lEhBrfz1eYz9icN0VdNy17VKqLbGpSutd9r/239nFT+kYo1h/ijjE6gi3byRUnOOn+
	 YfoMWNLMRTeTprYwWLwvoXwhfYVi2avfQqEYgidQVsYTMMYIqccpEENAqZCkRMAQAg
	 /5f8744cfUZ1uHMJc4dpdOS4P4ep7ttpOtmPqdGyeGLoSiahFqft20U+vCfAftRaqm
	 lwCU/sYJSiATbL9S4MYbhZeRv576XeMfXWZ1p/KiGEixkOjaP0a8SLe2N091S3scDn
	 f8ozxNYsYlJzECX0Qmav0b90sHD0opakIP8/lszoeRD74lUDw/9XT7y1lZEaM9lFMG
	 4ukX8c/wA4we7tN8WpITEOxc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 955DE40E019C;
	Wed, 30 Oct 2024 13:32:33 +0000 (UTC)
Date: Wed, 30 Oct 2024 14:32:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, qiuxu.zhuo@intel.com, tglx@linutronix.de,
	mingo@redhat.com, rostedt@goodmis.org, mchehab@kernel.org,
	yazen.ghannam@amd.com, john.allen@amd.com
Subject: Re: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Message-ID: <20241030133227.GDZyI1a5rheucn86qc@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022194158.110073-2-avadhut.naik@amd.com>

On Tue, Oct 22, 2024 at 07:36:27PM +0000, Avadhut Naik wrote:
> Currently, exporting new additional machine check error information
> involves adding new fields for the same at the end of the struct mce.
> This additional information can then be consumed through mcelog or
> tracepoint.
> 
> However, as new MSRs are being added (and will be added in the future)
> by CPU vendors on their newer CPUs with additional machine check error
> information to be exported, the size of struct mce will balloon on some
> CPUs, unnecessarily, since those fields are vendor-specific. Moreover,
> different CPU vendors may export the additional information in varying
> sizes.
> 
> The problem particularly intensifies since struct mce is exposed to
> userspace as part of UAPI. It's bloating through vendor-specific data
> should be avoided to limit the information being sent out to userspace.
> 
> Add a new structure mce_hw_err to wrap the existing struct mce. The same
> will prevent its ballooning since vendor-specifc data, if any, can now be

Unknown word [vendor-specifc] in commit message.

Please introduce a spellchecker into your patch creation workflow.

Also:

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

diff ontop of yours:

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3611366d56b7..28e28b69d84d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1030,11 +1030,11 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
  */
 static void mce_reign(void)
 {
-	int cpu;
 	struct mce_hw_err *err = NULL;
 	struct mce *m = NULL;
 	int global_worst = 0;
 	char *msg = NULL;
+	int cpu;
 
 	/*
 	 * This CPU is the Monarch and the other CPUs have run
@@ -1291,8 +1291,8 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs,
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
-	struct mce *m = &err->m;
 	int severity, i, taint = 0;
+	struct mce *m = &err->m;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		arch___clear_bit(i, toclear);
@@ -1419,8 +1419,8 @@ static void kill_me_never(struct callback_head *cb)
 
 static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(struct callback_head *))
 {
-	struct mce *m = &err->m;
 	int count = ++current->mce_count;
+	struct mce *m = &err->m;
 
 	/* First call, save all the details */
 	if (count == 1) {
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 504d89724ecd..d0be6dda0c14 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -73,9 +73,9 @@ struct llist_node *mce_gen_pool_prepare_records(void)
 
 void mce_gen_pool_process(struct work_struct *__unused)
 {
-	struct mce *mce;
-	struct llist_node *head;
 	struct mce_evt_llist *node, *tmp;
+	struct llist_node *head;
+	struct mce *mce;
 
 	head = llist_del_all(&mce_event_llist);
 	if (!head)
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index c65a5c4e2f22..313fe682db33 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -502,9 +502,9 @@ static void prepare_msrs(void *info)
 
 static void do_inject(void)
 {
+	unsigned int cpu = i_mce.extcpu;
 	struct mce_hw_err err;
 	u64 mcg_status = 0;
-	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
 
 	i_mce.tsc = rdtsc_ordered();

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

