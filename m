Return-Path: <linux-edac+bounces-3199-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C8A44052
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE124429E5
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613D2690D1;
	Tue, 25 Feb 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pn/GXGb1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5122690D7;
	Tue, 25 Feb 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489025; cv=none; b=lOtoh2oLwrat+o8Lj48yGz/JmtlSM9EJOvNCucuQHwKnwSrsiBqnwo+pU+TokzYZ2P2R2NYZ1iO3J5diInlUaOtsTfKtn4wAEaJuVUYSougCn2WBszkhL/knUb3gLKWrVoiT4qNKkPyCs+ApF7LkjhqhSHpHJoeTR6QSJ9XTktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489025; c=relaxed/simple;
	bh=nhLUfIoiOoIzAhHYROQBSPfuhD4U5LnXA/KST4muNII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9KOavUbDKFY0qun1jQfbs2WVryPO13r4c254bvKjYEfkZCJGXHryV/f9c2WhcqTZqvE5WdK1uxkflcUTntyOsFi/IpvA7S4VcoSL3U2yVyX8hrktmklnD8quSheeEvY6v3g1xGjyiWildqez88TKLCbCSdTMfdOAK3plwaPdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pn/GXGb1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5AF2240E01AD;
	Tue, 25 Feb 2025 13:10:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 28rS1vMLv5yB; Tue, 25 Feb 2025 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740489012; bh=HvQisBmjmpusVXJjXjZib7dbEOHzSN+VgPoUZiwWxik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn/GXGb1luquKQzyuo/8aYb6J5d33gPW7wX51ENbr9bd6S+QyO4SqY9v+BMyUECzw
	 /6E09SiDcnGElEpfQlylCF0DMo39mwA+Jmlvb+NySXm3AYGV0QJwJDIaOEIlcNjWlz
	 JKtS6L9JdkTiaCsCsexQtn8gbtGwEYNbeJ3xp3j4fRcA07o7AUIot4Ie5f+gXy0jC0
	 aQFdXZRll5hzF029Zudf6cZc/flRE06g/gBWKxAkz6LQpPHGc0gDTiar6V9kjFt0q6
	 g0+stGRUy8Z0Ajl6i/Ckk1S+I52OIpJpha7lXUK7U5A7dwHJd8LWSAIpJtUgU09n7f
	 d7Q5l80DBb+J0CIirdYW7hBKvHt0wN0JoxIYmna/Q3o4vVN/i8Y9lzGOrNMDqGn3vv
	 nUjc9f4KcFHdDuM9MYemrXrRTvJ6+HHrhE6RRMMK3barEQl7Phpg4+TtZKi62wdxPg
	 wolCeIoHN6HUtPMsqbiLX+i8NdLonoFhjx5YqnlKKfTPDqAoHRrjn9lKdZL9hoLdJ0
	 7K7dAFceHy50nWqwMxuOYHoelmsKanZWk/+S9kRLYdotwQOe3tzrafloqPwKUhBQLM
	 Bk0j2eEaPNa4zXY+C4XnEAectJ2ErggZSfpUe8fEEj4vLew20A5TwjJnBicTJvuDvF
	 2OsmCmlw4lFeyFFAchM3xKQY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A86B40E0177;
	Tue, 25 Feb 2025 13:10:07 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:10:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v2 2/3] x86/mce: Move message printing from
 mce_notify_irq to mce_early_notifier()
Message-ID: <20250225131000.GKZ73BKIW4SqS4cbbE@fat_crate.local>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-3-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210154707.114219-3-nik.borisov@suse.com>

On Mon, Feb 10, 2025 at 05:47:05PM +0200, Nikolay Borisov wrote:
> Informing the user that an MCE has been logged from mce_notify_irq() is
> somewhat misleading because whether the MCE has been logged actually
> depends on whether CONFIG_X86_MCELOG_LEGACY is turned on or not.

That text needs update in light of what we talked about when looking at patch
1...

> Furthermore it was reported that actually having a message triggered
> when an MCE is generated can be helpful in certain scenarios.

That's too vague - needs proper justification.

> Improve the situation by lifting the printing to the generic
> mce_early_notifier() as it's executed always and is independent of any
> compile-time option.

Meh.

> Link: https://lore.kernel.org/all/CY8PR11MB7134D97F82DC001AE009637889E32@CY8PR11MB7134.namprd11.prod.outlook.com/

Ah, there's the justification. I guess...

Just don't put "customers" in the commit message.

> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 89625ff79c3b..d55b1903fde6 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -591,15 +591,8 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
>   */
>  static int mce_notify_irq(void)
>  {
> -	/* Not more than two messages every minute */
> -	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
> -
>  	if (test_and_clear_bit(0, &mce_need_notify)) {
>  		mce_work_trigger();
> -
> -		if (__ratelimit(&ratelimit))
> -			pr_info(HW_ERR "Machine check events logged\n");
> -
>  		return 1;
>  	}
>  
> @@ -609,6 +602,8 @@ static int mce_notify_irq(void)
>  static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
>  			      void *data)
>  {
> +	/* Not more than two messages every minute */
> +	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>  	struct mce_hw_err *err = to_mce_hw_err(data);
>  
>  	if (!err)
> @@ -619,6 +614,9 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
>  
>  	set_bit(0, &mce_need_notify);
>  
> +	if (__ratelimit(&ratelimit))
> +		pr_info(HW_ERR "Machine check event detected\n");

Well, the previous "logged" was correct.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

