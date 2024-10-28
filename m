Return-Path: <linux-edac+bounces-2317-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1EF9B314D
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 14:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991EEB20AEC
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798B1DA10B;
	Mon, 28 Oct 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eeT5KRSU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988042AE8C;
	Mon, 28 Oct 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120843; cv=none; b=fVl/wZ6621vYZWucdzq1tngsrLJ1Qlkxf/pFoCkU0gB2HzrtPqtJMQ4zBYecNQCU6lVR/+1i5d7EZfYrx/pyUF9ETB1t3OD0YfW4S1hUTmPsUBCaWBOU3fRXWEMMwb3DN6a2kTNaBTyytmo8PIMlGY5XqxxQy96GHqPzOt6eo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120843; c=relaxed/simple;
	bh=EAf+q/0bHB6df79KwR1+x1+/r4GFQp9Y3COiC0gEsXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTzuhA+RxcpgPlH1LFDlvCOMsTxZuW7qrbNBL9lkcB6JPj3G4k/79wInj87N73SPi/Hby8F873jlvcVF0f5yvUhptUDp9noGd9wwMR5wrro5/wx0TK624/yriy1f7wdl1MXZjB7P3SLSqZTz7ULh0eJHw/eh13OLv2t8JXRz3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eeT5KRSU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D5EE40E0219;
	Mon, 28 Oct 2024 13:07:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3l4fyaIPtlg5; Mon, 28 Oct 2024 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730120831; bh=YckLSljqu9xEozoNAj4eikFtKDm8vIiY4UFulPKns2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeT5KRSUa6E5MVhXjs85bZZ09byRJVaBa7+bzh25kYTwoeD77FeQOc7axye+y5RD3
	 o3d33Fq9r7RVxo37C1I8ihs4/qk750igPU39XiYelCUJNqQPBcVAJj5f3EizGF75P3
	 okT47E9aaKmJu7rhLIw7EgeSX7MT79iWjgYpcHC7O/+3ycE/rRlXor3VR3/P67ZTxt
	 4bwDJQwbKijdJLTJiLL9WHo8LFeVdRnLAchaGbianoZcGln1seuAzrXcJctmtYeRFp
	 xdECguV251uG2JbuQCmc885MGJ+r2jv2E0KjbvgFaZZGjLGDY4J3Mfp+gbNmo6dJm1
	 GOtEnPCyi99pPjVe6SXVFDuv6IH+68YY50hPyxoTUbiX01JogqEKGgZvW6vx042MMr
	 ua23L4MzcjVqzwZdYAmg9XaVm4gPxd7D693CWmoW/AUdaPjo3o3af/hnOK8zz/XtIx
	 4Uh8iaclZ/bf4qTghMF3w+K8pYGxZ9JN27g46TvnFsS/5Re8Tj+AS3KkOu+JoJ1kAF
	 Oiju3+xKBnjYWId/7Ghpr+BCWKtkfvutqsP91jcTzS+uZ4VXH3sz+xfyfDxpUVVoD/
	 4U002cGf5JIbRqdcNKIDclKwyMhkuRjQHRCtz9ndr1JL8TgoMlRT5X2lzlIx1c1Khp
	 1KgOtoiKdVWcegt2s4EED1tQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B26540E0184;
	Mon, 28 Oct 2024 13:07:02 +0000 (UTC)
Date: Mon, 28 Oct 2024 14:06:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] x86/mce: Make several functions return bool and
 rename a function
Message-ID: <20241028130656.GTZx-McByoo3wsR3__@fat_crate.local>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-4-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025024602.24318-4-qiuxu.zhuo@intel.com>

On Fri, Oct 25, 2024 at 10:45:55AM +0800, Qiuxu Zhuo wrote:
> @@ -1748,7 +1748,7 @@ static void mce_timer_delete_all(void)
>   * Can be called from interrupt context, but not from machine check/NMI
>   * context.
>   */
> -int mce_notify_irq(void)
> +bool mce_notify_user(void)

So why are you not fixing the comment above it too then?

Have you audited all the code to make sure this function is not called from
IRQ context anymore?

Did you do git archeology to find out why it was called "_irq" at all in the
first place and why is it ok to change the name and adjust the comment above
it now?

In any case, this change needs to be a separate patch along with all the
explanations why is it ok to rename it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

