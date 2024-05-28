Return-Path: <linux-edac+bounces-1145-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27348D182E
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 12:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7024C28E4AB
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770C31581E0;
	Tue, 28 May 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J3eidjr2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576AE17E8F4;
	Tue, 28 May 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891087; cv=none; b=PxTyvrHIgisvDnviP+CmWQEzGkV07JOIXP/z7dfoljheGUcz7XMbDjJYQSqzc7+ATVURN+1LDaYWajKz5ncb1tV6nmphCEe5lFH8+EyJEMooSSjuyhsjYrULmsIWLCWWaihsAUrsjuCWF4Aha1TTiicRmo+QV7eY1x+MvUUolVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891087; c=relaxed/simple;
	bh=WX0Sfguj1q7WBIbEsFwGyUZYnkEBpUJI7BARs9P7IUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw2AK/L5x4AmHEbqMjbl/nIgXyfYRXvGEqVpp9MJCnu8d614AMr0AeobkU3v0aXjMEQqcB52SCTo8QK13tiZ9g2bGtYW8Azj+uQoFrBXMq93SQwlFmNYvfQcurmB0VR3mQjGVEF31+5Pw22RHmWvrskWwHumSDmovyLBSUJNog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J3eidjr2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 63A2F40E0177;
	Tue, 28 May 2024 10:11:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ae9FXBsyCL2o; Tue, 28 May 2024 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716891080; bh=AIBrVYCr7tAdiqlA1FEQBMuJmHr3pmQsKYM/c/oapQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3eidjr21K9yHY3+YqrY7FXJ9UcMxmlbKgYdEn6/QTjFnkV9r4G25LLhYIuBUf5Rh
	 /EOb5YPeID4y3CwLCe9YVpsqOE1vnt4/BIRF1Jw3akmECIRAJ38WACVPcc+Anf6bdq
	 hWIIlPaO1L4Zyq70ShwVw6U5Xe4qicMPJ0ZM/D89vEu46FkSzkkDQSPgb0ZIrsdD8F
	 makAEuJS3I64PBQibfvZgRQttvdkYAAyav2oNxImTvDangfBWJV2cuMwwI8+AQuuTI
	 3cDS8R6LLXWzNGk0WT9YVLkD3uxJJ5A0Y1TuSOGBchDq7byS8wuxjCt34s8I+YcwLI
	 RNPUH2yqT/sNrXr1mtCxDHTpsTmmhhZ3BhjP4SJ4+MXVwtKnsCSGY3jC1k+vyLCICg
	 5NJQZLUukFf90oKBjEvaThq053NuS7tjfyZkkDVYrcIzqu1AtvVONlCPQt8G/POssm
	 7YUQ+jPbcSkc4yJeafRUvm3jvRb8njq4fdXvjwTtla9cTpwoEpzk2UP1v9zmLqrGuA
	 DL1svfFO4rGvxBw9KZO6K/dXR1E9IeUfTcRx9sMt/V9GElEYuBlqseQ2CI1nWJaR6J
	 bNNxQm47589FWvPDEZCokf3XqpXJgyfvVwebO6CkvRb8ZFQPJ/HPBYIPykQkG+Dix/
	 BMFVJldSTg+Opk5zH1aUQjEA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32CEB40E02A8;
	Tue, 28 May 2024 10:11:13 +0000 (UTC)
Date: Tue, 28 May 2024 12:11:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 3/4] RAS/AMD/ATL: Validate address map when
 information is gathered
Message-ID: <20240528101112.GFZlWtwLlqiKjiZzn9@fat_crate.local>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-4-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506154605.71814-4-john.allen@amd.com>

On Mon, May 06, 2024 at 03:46:04PM +0000, John Allen wrote:
> +static int validate_address_map(struct addr_ctx *ctx)
> +{
> +	switch (ctx->map.intlv_mode) {
> +	case DF2_2CHAN_HASH:
> +	case DF3_COD4_2CHAN_HASH:
> +	case DF3_COD2_4CHAN_HASH:
> +	case DF3_COD1_8CHAN_HASH:
> +		if (!map_bits_valid(ctx, 8, 9, 1, 1))
> +			goto out;
> +		break;
> +
> +	case DF4_NPS4_2CHAN_HASH:
> +	case DF4_NPS2_4CHAN_HASH:
> +	case DF4_NPS1_8CHAN_HASH:
> +	case DF4p5_NPS4_2CHAN_1K_HASH:
> +	case DF4p5_NPS4_2CHAN_2K_HASH:
> +	case DF4p5_NPS2_4CHAN_1K_HASH:
> +	case DF4p5_NPS2_4CHAN_2K_HASH:
> +	case DF4p5_NPS1_8CHAN_1K_HASH:
> +	case DF4p5_NPS1_8CHAN_2K_HASH:
> +	case DF4p5_NPS1_16CHAN_1K_HASH:
> +	case DF4p5_NPS1_16CHAN_2K_HASH:
> +		if (!map_bits_valid(ctx, 8, 8, 1, 2))
> +			goto out;
> +		break;
> +
> +	case MI3_HASH_8CHAN:
> +	case MI3_HASH_16CHAN:
> +	case MI3_HASH_32CHAN:
> +		if (!map_bits_valid(ctx, 8, 8, 4, 1))
> +			goto out;
> +		break;
> +
> +	/* Nothing to do for modes that don't need special validation checks. */
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +
> +out:

s/out/err/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

