Return-Path: <linux-edac+bounces-1378-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89B917F46
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89EE2812CD
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552717D897;
	Wed, 26 Jun 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="errIfb3n"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCC17D37E;
	Wed, 26 Jun 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400269; cv=none; b=oJC/iarxTimpP7vj7cmWuUmQQlgCWb7ArXnmM2us64GdDHBN7xX4YqOori8HBM8jP2UXM4+lJfE3QxtyhhVOEjZUSHZ++GlO1Bg3epualIZy6jKoH6I89hxrOkSwQW+bxZpWRvJFU4/9/izgSEuIUfYEtVP/BI8zKMeWZ1fw7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400269; c=relaxed/simple;
	bh=hoCPWHBa5CHJcMp0XPeSVCrfiVoqTeSf+bX5intC7n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxk4EUjOwcK7FTJeeQVhKok0hzXnBsf68j5AVlEvbIDnEIbFQa8qwFeqR8uIKctagLghChWZLnxYYCWI1avXNceKZVRXSFyD2TLO35HrdPs3bObS08XUBxyUFrDpfj7xa6uJBAiTPAPiSThCUfjsxWeqm60RKQ682IJeWHLCq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=errIfb3n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E0A540E021E;
	Wed, 26 Jun 2024 11:11:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XpD5mec6zF46; Wed, 26 Jun 2024 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719400259; bh=53K4TxydQGcpKMi5vGJq+ALpdG1TuX/XIhPDiOI6pXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=errIfb3nCpGgParK4Myt9duaXLxPYwfYP3AjdFCxR08UDpqhioS2sRPK/LCjhfPTu
	 5qgtyGuZodklFbfOHNy6HRImExoY5rj0Bu1TeMvButEseAXd0o2s8coyUsWCtbSsrm
	 pHvTC2pHO/4iUEQa5kZ79BdV+u3aaEfQlBHzHOUNHJBqYWbBfDqeSkkjtO9QMVTKOZ
	 hMRXeqEq9V8LA5VwgErdYzI8leUQC6+Wxsj6eCP0rMbKg2PBNxeaTD5sb5Tw9Qm2vq
	 SXIyD/h8B0trqslz/PWDb4WKXiroB+d5OJNk7fUZfRW1mGddmmm2gXIjUkMNRp/4mi
	 F/Mqg07jWzFgIqXBixyBB8PZppsrY/d99fhiRPqm5ukslEItZ/25ZrJTcB1FM26jkx
	 aHF5RhJCHOtbnGHiJYiXE6aT8u2RmnKw8fR8Hz3yljg374w8qNvVm/ue7eycHxXoMg
	 wI9M3YPy6MeCKvruLWlD4tHsGTVaIueN/EL8Y6RUFYqKGRP4fUndWV9bEPEUNZ/kCr
	 3VMNfQG9hTeFoEYkX2v+J8Q94bA7zXS58h3HOUAHPE4lGHvMNBtP2rjXMWGP17umFn
	 jQDPGpkW14cpHQYyiyoy6hU+/3Dak24uxKMTG84Fjb5qD9H6VoztrDaz4hioKDOPi2
	 ATr58tSZcSiy1gM4VnoNAZO4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A319540E0219;
	Wed, 26 Jun 2024 11:10:41 +0000 (UTC)
Date: Wed, 26 Jun 2024 13:10:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, avadnaik@amd.com
Subject: Re: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-3-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625195624.2565741-3-avadhut.naik@amd.com>

On Tue, Jun 25, 2024 at 02:56:22PM -0500, Avadhut Naik wrote:
> AMD's Scalable MCA systems viz. Genoa will include two new registers:

"viz."?

Not a lot of people outside of AMD know what Genoa is. Zen4 is probably a lot
more widespread.

> MCA_SYND1 and MCA_SYND2.
> 
> These registers will include supplemental error information in addition
> to the existing MCA_SYND register. The data within the registers is
> considered valid if MCA_STATUS[SyndV] is set.

From here...

> Add fields for these registers as vendor-specific error information
> in struct mce_hw_err. Save and print these registers wherever
> MCA_STATUS[SyndV]/MCA_SYND is currently used.
> 
> Also, modify the mce_record tracepoint to export these new registers
> through __dynamic_array. While the sizeof() operator has been used to
> determine the size of this __dynamic_array, the same, if needed in the
> future can be substituted by caching the size of vendor-specific error
> information as part of struct mce_hw_err.

... to here this text explains what the patch does. I guess it is time for my
boilerplate text again:

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

Imagine one fine day you're doing git archeology, you find the place in
the code about which you want to find out why it was changed the way it 
is now.

You do git annotate <filename> ... find the line, see the commit id and
you do:

git show <commit id>

You read the commit message and there's just gibberish and nothing's
explaining *why* that change was done. And you start scratching your
head, trying to figure out why. Because the damn commit message is worth
sh*t.

This happens to us maintainers at least once a week. Well, I don't want
that to happen in my tree anymore.

You catch my drift? :)

So, now, how are those new syndromes going to be used in the tracepoint and
why do we want them there?

> Note: Checkpatch warnings/errors are ignored to maintain coding style.

This goes...

> 
> [Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]

Yes, you did but now your SOB chain is wrong:

> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

This tells me Avadhut is the author, Yazen handled it and he's sending it to
me. But nope, he isn't. So it needs another Avadhut SOB underneath.

Audit all patches pls.

> ---

... right under those three "---" as such notes do not belong in the commit
message. Remember that for the future.

>  arch/x86/include/asm/mce.h     | 12 ++++++++++++
>  arch/x86/kernel/cpu/mce/amd.c  |  5 ++++-
>  arch/x86/kernel/cpu/mce/core.c | 24 +++++++++++++++++-------
>  drivers/edac/mce_amd.c         | 10 +++++++---
>  include/trace/events/mce.h     |  9 +++++++--
>  5 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index e955edb22897..2b43ba37bbda 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -122,6 +122,9 @@
>  #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
>  #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
>  #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
> +/* Registers MISC2 to MISC4 are at offsets B to D. */
> +#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
> +#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
>  #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
>  #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
>  #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
> @@ -132,6 +135,8 @@
>  #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
>  #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
>  #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
> +#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
> +#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
>  
>  #define XEC(x, mask)			(((x) >> 16) & mask)
>  
> @@ -189,6 +194,13 @@ enum mce_notifier_prios {
>  
>  struct mce_hw_err {
>  	struct mce m;
> +
> +	union vendor_info {
> +		struct {
> +			u64 synd1;
> +			u64 synd2;
> +		} amd;

I presume the intent here is for Intel or other vendors to add their
vendor-specific stuff here too?

I'm also expecting that shared fields will be promoted up to the common struct
namespace. Pls add a short comment explaining what the goal with that struct
is.

> +	} vi;

Call that "vendor" so that in the code you can have

	err.vendor.amd.

or

	err.vendor.intel.

and so on so that it is perfectly clear what this is.

>  };
>  
>  struct notifier_block;
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index cb7dc0b1aa50..fc69d244ca7f 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -799,8 +799,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>  	if (mce_flags.smca) {
>  		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
>  
> -		if (m->status & MCI_STATUS_SYNDV)
> +		if (m->status & MCI_STATUS_SYNDV) {
>  			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
> +			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vi.amd.synd1);
> +			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vi.amd.synd2);
> +		}
>  	}
>  
>  	mce_log(&err);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 6225143b9b14..3bb0f8b39f97 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -189,6 +189,10 @@ static void __print_mce(struct mce_hw_err *err)
>  	if (mce_flags.smca) {
>  		if (m->synd)
>  			pr_cont("SYND %llx ", m->synd);
> +		if (err->vi.amd.synd1)
> +			pr_cont("SYND1 %llx ", err->vi.amd.synd1);
> +		if (err->vi.amd.synd2)
> +			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
>  		if (m->ipid)
>  			pr_cont("IPID %llx ", m->ipid);
>  	}
> @@ -639,8 +643,10 @@ static struct notifier_block mce_default_nb = {
>  /*
>   * Read ADDR and MISC registers.
>   */
> -static noinstr void mce_read_aux(struct mce *m, int i)
> +static noinstr void mce_read_aux(struct mce_hw_err *err, int i)

This whole conversion to struct mce_hw_err here belongs logically into patch
1.

>  {
> +	struct mce *m = &err->m;
> +
>  	if (m->status & MCI_STATUS_MISCV)
>  		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
>  
> @@ -662,8 +668,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
>  	if (mce_flags.smca) {
>  		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
>  
> -		if (m->status & MCI_STATUS_SYNDV)
> +		if (m->status & MCI_STATUS_SYNDV) {
>  			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
> +			err->vi.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
> +			err->vi.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
> +		}
>  	}
>  }
>  
> @@ -766,7 +775,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		if (flags & MCP_DONTLOG)
>  			goto clear_it;
>  
> -		mce_read_aux(m, i);
> +		mce_read_aux(&err, i);
>  		m->severity = mce_severity(m, NULL, NULL, false);
>  		/*
>  		 * Don't get the IP here because it's unlikely to
> @@ -903,9 +912,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
>   * Do a quick check if any of the events requires a panic.
>   * This decides if we keep the events around or clear them.
>   */
> -static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
> +static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, unsigned long *validp,
>  					  struct pt_regs *regs)
>  {
> +	struct mce *m = &err->m;
>  	char *tmp = *msg;
>  	int i;
>  
> @@ -923,7 +933,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
>  
>  		m->bank = i;
>  		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
> -			mce_read_aux(m, i);
> +			mce_read_aux(err, i);
>  			*msg = tmp;
>  			return 1;
>  		}
> @@ -1321,7 +1331,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
>  		if (severity == MCE_NO_SEVERITY)
>  			continue;
>  
> -		mce_read_aux(m, i);
> +		mce_read_aux(err, i);
>  
>  		/* assuming valid severity level != 0 */
>  		m->severity = severity;
> @@ -1522,7 +1532,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	final = this_cpu_ptr(&hw_errs_seen);
>  	final->m = *m;
>  
> -	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
> +	no_way_out = mce_no_way_out(&err, &msg, valid_banks, regs);
>  
>  	barrier();
>  
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index c5fae99de781..69e12cb2f0de 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -792,7 +792,8 @@ static const char *decode_error_status(struct mce *m)
>  static int
>  amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  {
> -	struct mce *m = &((struct mce_hw_err *)data)->m;
> +	struct mce_hw_err *err = (struct mce_hw_err *)data;
> +	struct mce *m = &err->m;
>  	unsigned int fam = x86_family(m->cpuid);
>  	int ecc;
>  
> @@ -850,8 +851,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
>  		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
>  
> -		if (m->status & MCI_STATUS_SYNDV)
> -			pr_cont(", Syndrome: 0x%016llx", m->synd);
> +		if (m->status & MCI_STATUS_SYNDV) {
> +			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
> +			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> +				 err->vi.amd.synd1, err->vi.amd.synd2);
> +		}
>  
>  		pr_cont("\n");
>  
> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 65aba1afcd07..9e7211eddbca 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
>  		__field(	u8,		bank		)
>  		__field(	u8,		cpuvendor	)
>  		__field(	u32,		microcode	)
> +		__field(	u8,		len	)
> +		__dynamic_array(u8, v_data, sizeof(err->vi))
>  	),
>  
>  	TP_fast_assign(
> @@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
>  		__entry->bank		= err->m.bank;
>  		__entry->cpuvendor	= err->m.cpuvendor;
>  		__entry->microcode	= err->m.microcode;
> +		__entry->len		= sizeof(err->vi);
> +		memcpy(__get_dynamic_array(v_data), &err->vi, sizeof(err->vi));

So that vendor data layout - is that ABI too? Or are we free to shuffle the
fields around in the future or even remove some?

This all needs to be specified somewhere explicitly so that nothing relies on
that layout.

And I'm not sure that that's enough because when userspace tools start using
them, then they're practically an ABI so you can't change them even if you
wanted to.

So is libtraceevent or all the other libraries going to parse this as a blob
and it is always going to remain such?

But then the tools which interpret it need to know its layout and if it
changes, perhaps check kernel version which then becomes RealUgly(tm).

So you might just as well dump the separate fields one by one, without
a dynamic array.

Or do a dynamic array but specify that their layout in struct
mce_hw_er.vendor.amd are cast in stone so that we're all clear on what goes
where.

Questions over questions...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

