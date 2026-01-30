Return-Path: <linux-edac+bounces-5688-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xZJgMy88fGkXLgIAu9opvQ
	(envelope-from <linux-edac+bounces-5688-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 06:05:51 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D150B72E9
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 06:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D2E63011C6C
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B32F7468;
	Fri, 30 Jan 2026 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeA1xWAf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441151C32FF
	for <linux-edac@vger.kernel.org>; Fri, 30 Jan 2026 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749546; cv=pass; b=BfNegBD3FoJhEFk1DPyoyM+Cl7K4FWgxwuYNZRzHhnTFegeuJDKavQJ6kWHXxK9P9m5Y6cvlkbTrL9fuak4kx/V/5Ba6NBTszCL8yTeuxwy36tYqh2O6zNEB4fcrdGnfGQobdABVYVSSQ2QaIe6iiYBHA6PuRfCQb+SkdH0NmWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749546; c=relaxed/simple;
	bh=AvoWYB3KJ4OROhVKIlhFs/+biSagymAo/Xsw0uq41FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPjOWRe8WOR0b66ZHK2J5WV3m3cjnJzU8zFSjGI4Nw/UQdXYwiAtwtC/MNNdf4VmVAYkoRKBgrSU/tbdzhOGL3BlJ769gxRN9mBwsa4VkT9Ozf1yG64nWXklggEeJlnT6m4hFn1QValFx8RqjZCcYdpAWZ7C6V7pKu/uQzkYGg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeA1xWAf; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-894723da7dfso23921006d6.1
        for <linux-edac@vger.kernel.org>; Thu, 29 Jan 2026 21:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769749544; cv=none;
        d=google.com; s=arc-20240605;
        b=YCc/Lw8bRE02U98zHPqZrClwGEyk6GHBYOLTdG2tKDDPKYqFf2PLfuM+ZPUis4tFQ0
         luQASZC6yre3JpXOkymOG+p1cHA3MRuh3oDvAaMkV3qprrJcvPhAbcMINMrkfTfWjggG
         hLJbmms3zOl0g4+I+u4b+3/n5rSNdPYsU0kMMko1dEJdEGU9G5cZnqVr4vKPBtFrSnWf
         4/cTMM96wd5P9LCRwXgaeBpuNJtq8eMfQhHYNQJbDXsVqstTnnd5cTTpuZaUdxxPpAEl
         gKt1hY/c+zVRV2acRFpsaW4MGQkKg5pMVJuOOI5bxkNJo/+C6UNs3RNWj6VPbPbrrlNY
         /yqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZlp4Xt6hcP/9c/dCDOClMcZ28UUC7Wo256i10G028g=;
        fh=OmjNmGO1b3kSw0pBJ6lREkS09BkY3Q6R7IHU4wey20Q=;
        b=kX0qAIO9kkK9WxgP3TLZQfVco2B98/1hOYgTmAahavhqpXcCK4mFsOtUUaqkFZ39u0
         yHwOC0pFfrmCNbIoleP5RyrYCsIwLcFt5qquoOociUX3MxXDTWrfhoEOdgS0FmNQZqqY
         D7kUiApFMfeWKV9EKTMmU/hkHWZHzvrtE4BO9Km3MpC3ry5udUlwDdAdHC5yUGWXIOSp
         pXMgWGkNkBkMyS+u1zu/QSBJ6a6+9LfS7z11U6Dn44M1NObk+5TbaGuqB+DZwV1mC47w
         dmL9+RoI0l28cqHGDzwWSyY4bD3RLzyAYGLbJZpeRwQuuOky4YhUe8wVD4IsQ0widl3w
         gYLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769749544; x=1770354344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZlp4Xt6hcP/9c/dCDOClMcZ28UUC7Wo256i10G028g=;
        b=KeA1xWAfSZ3SuqpWFWDiHVuaQSmtmKOoFWhWLrXt5EgQ0Bg3PEV7NgrsaLonpRP3bz
         wGtxHIxzcb/VYMPwzn5074mhC7vixBTugCpoaK8ld53UdI3V0Op6WzCeCis+v2ByE8pV
         cdImK4MJ6A9it/8N+CDVNW3jKjyaJbg+qdquk2+S0d6H+aBrNLNlBm7xp22u7Dr8AU0Z
         pAAjcMGZojG/wz9GCoaucGAAuRvPH7xkr9mVySL0SlNblARpvAmL82SUE6611oVCzOcW
         7JSN3b7CkBJ0vddYdWQSPjFxJPuYH2yOL9a9VbR8WKL9ym+nSDPxLdwqpqg12PktE2dL
         P31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769749544; x=1770354344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZlp4Xt6hcP/9c/dCDOClMcZ28UUC7Wo256i10G028g=;
        b=Wth0BfazKANeZFLJTodCQYIGRL7+Bpr8yqI7LWFVXMdTvTZSvbqK28jcV1JZbe2a/w
         Jm2qCgHSPckMQaw2iy9desynCjUts9o888lAPudZ33baodi6nZn2sAIBQmPnsK1qljPt
         a/FmuMStBSTZSqDdpHhuPie+sPC4KDR0ScTFCpGvE6M7ADufi7r7V2Sj89L7alwxtdBk
         BIQYL7pUFicSd1NoVwNCl1FbK7ZzyZkpxsyLESolanBtzda1yytFkGJSQvux4uBeJkvc
         T0Rmwkuk3h06S207zYZ8kb2VcYtjwJ/ctdzniZ/cKxS/KhiWcK1l+QqMvy1/6AzKYr9h
         QF9A==
X-Forwarded-Encrypted: i=1; AJvYcCUx2+mbsVoZTCY3MadQPLvJ25DGX1CZs7iMAkKP0rd0kPNdEWut6I4wRxD9SX26GsXWs0DlcWM5YtpY@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZchw2N/zu1ISmVcRQjWb8idYi5fpUDhvDsLnDiVgAdmNtw9w
	kM0F6mDFmo6wk1yNw2xM1pyg+dDDek63+PB4Yebx7KIHCqDyojIsu2z1hJJueaQScTAytOMAg1K
	cE6vSS7G/E5fC0dH0pPGj8JQhOM4lcdI=
X-Gm-Gg: AZuq6aJsSz3/7zfFK3RUK2n7H0esuxzh/0eAw4dSiD7NH/n2sW6Qx4bz+jvtQH8WG8M
	dDvJoV8EgxRO/XwwTxl9SOhRQohvw22ncvep9IE1wxmLNAV4LlXzBjvnf6pxlGQEwhl95vvg/Tx
	MBcRLedVAaXJtQ1oSn27ii/qfC154118kl68InTw9BPIaFgh2cRGZrovgMour6Xst89TWisws9e
	ZAwxIUT5CZMLPE3KxSAh8C1H7kjTNIRCd5NQwCFe9qEWHrvFPZHF3wxGEQCELq0EMurjb/0cU7K
	gMsAWRd7fiIXr6McS/vzd4/oEZqrTeLefKPE00LJ88YhnI/BGXGmbRlp
X-Received: by 2002:ad4:5d66:0:b0:890:3eb8:1ee3 with SMTP id
 6a1803df08f44-894e9f6d92dmr25716646d6.15.1769749544152; Thu, 29 Jan 2026
 21:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129082937.48740-1-enelsonmoore@gmail.com>
 <20260129104838.GAaXs7BumfNkuhVovO@fat_crate.local> <SJ1PR11MB608338017FD8E4D07F689A21FC9EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <01BCCA37-F6A2-458B-BFE7-99C7724CDDEA@buttersideup.com>
In-Reply-To: <01BCCA37-F6A2-458B-BFE7-99C7724CDDEA@buttersideup.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 29 Jan 2026 21:05:33 -0800
X-Gm-Features: AZwV_QiPGoof7i0H4p5UafcM8gop_vSpiUJqR0GKmyKo3qoUfqUGS7uTHp-Y2Tw
Message-ID: <CADkSEUhGMcBh+BZUwwK2CiP2X+KBsii2W7XNGU2zutVr0nkffw@mail.gmail.com>
Subject: Re: [PATCH] edac: i82443bxgx: remove driver that has been marked
 broken since 2007
To: Tim Small <tim@buttersideup.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5688-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[buttersideup.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,scribd.com:url]
X-Rspamd-Queue-Id: 2D150B72E9
X-Rspamd-Action: no action

Hi, Tim,

On Thu, Jan 29, 2026 at 11:27=E2=80=AFAM Tim Small <tim@buttersideup.com> w=
rote:
> This particular driver did apparently get used by Akamai quite heavily an=
d widely  but all ancient history now. The Radisys r82600 edac driver  r826=
00_edac.c was closely related hardware from the same era, and can probably =
go too (although being embedded hardware, it's possible its production life=
span was considerably longer).

Thanks for your input.

I can't even find any information online about the Radisys 82600 (note
for anyone else trying: not r82600) beyond its own documentation and
one reference to its use in a Nokia 2G GSM base station:
https://www.scribd.com/document/50855914/AS7-C
I'll send a patch to remove its driver.

Ethan

