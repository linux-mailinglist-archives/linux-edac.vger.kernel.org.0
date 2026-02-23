Return-Path: <linux-edac+bounces-5739-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPkgM3tsnGlNGQQAu9opvQ
	(envelope-from <linux-edac+bounces-5739-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 16:04:27 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4AF1786C6
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F03310A624
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600926E6E1;
	Mon, 23 Feb 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVu8MaRE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7927E049
	for <linux-edac@vger.kernel.org>; Mon, 23 Feb 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858715; cv=pass; b=PDcTqMQ8/8lSwHaJ770ZZIlZgEgzmBcLob2z6De6Thoft5PUAEXWYCMlnM8GAm/O9FjAn8zWKSyoRPWV9YuBRZZ1kB0xCFu4ZyGFXwu6ySCA6R4CeTVWOM/tqp47XUpHXMeUsN2NcSPkRhN5gwDYvp6RwO1uirfl9PwpnMCIIu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858715; c=relaxed/simple;
	bh=xVFRSrlvIGdGmh6nXcU3quee6dziM5MmqPkAm3zDOXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrhxPs8TuwhiMzNExlQB7T8m/qoA4P7cXpC9RMjiBdigbeCjGo7eso0XJ3J0j9QTw+SODOjZYQE3PUo0F/x/3KaGEHFI3uN+8WEcptLfTOHfCi1wSYzOuv3U0f/Q7gdX7XBincnDW1C1flD2Pf0IELILF+EC8p8isI3xroNgyZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVu8MaRE; arc=pass smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65bfe9c585cso7155600a12.0
        for <linux-edac@vger.kernel.org>; Mon, 23 Feb 2026 06:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771858712; cv=none;
        d=google.com; s=arc-20240605;
        b=i7px4JWf2taL5GpgOTYSdnJNAuDJKaFvlEwSZyI2CPhE879eEjSVf3zIYRL8DeaVmp
         wQIDQgDxM6RnV/a50AOIZHAwuaiDnNw30ATozZZx9FDL0rClwJOzBG4LuUgnZVb8IOj8
         jIcPqj6ZuKnmyHPPVy5QGot0tLJZqF4Gh6zAfimt4VOZkP9rreWy8qYs5/2DvYhW9GRu
         3ttRcu4TJM51fFxLYPsqgdWSm6s3NoAdn5e4txLH+EMTRkgaK9MEGyOXqnDMHlGH5DIy
         wXvnvNJ9Nf+e8uGGYYU2D8FA4cDeIa9V12Ltltv80oa5MU/ZjhV+AlvGW9ARV5PNtu+F
         ZbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVFRSrlvIGdGmh6nXcU3quee6dziM5MmqPkAm3zDOXg=;
        fh=XR5gQjY5ungr7gPHtx/4/Ghps7RwjsfHxz9JXsULXXQ=;
        b=F2YUBamVpRFIE8fRRN6nV45tq2ax1u/Wf4048qkHQ33kj+pLzNAwTwtg5LcjxU40lB
         2btsQNIpq8qlk3mHwg7j0ljq4M75iHGUH/6xdg92iTIdxJ3qZa6qjfCXwSyiDgh2JjRD
         A1Z45KNWoH0UJHjJQrAivhRGiMY+WAmH7JQmYFlfyTyrrutpE+/UGGHO1yCBNCCMug90
         Th9XJOvYBWYcvrBqSi2p9Y+/8xzekVYt3dlxQSkts+x+57tugvX+n8pfdVd0nnorDzG9
         pJoS2rs2wOIWC2WuIvgcwwsHUTUF6K3ZHHlbwtQppctM48zNm1H6eOq9woqsuwJgfnsZ
         Mgkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771858712; x=1772463512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVFRSrlvIGdGmh6nXcU3quee6dziM5MmqPkAm3zDOXg=;
        b=DVu8MaREuLTiN6v0MqOa/5YY686Fk6xZJfJIn5moRc/ThzC0M93k/H1F7Yv6FwJ4Gh
         dqp8BPWaf6vdLIp9Paz5fKIXmTPTKO20gxr6bF00g7mTEsExdryh8WJ8JPwf1hWIh2We
         wnd8BBgz0ZH20DaxCORJtYwLPLcNVbkU/wc3HNSQ4S00r6SC9Zv94iCCwMvXDlu77iBe
         Qr+aTkdfmDLG97TNyHJYHhGkP2l2/gVYomEDHDKh1QPYFagkGK9hXCnNtGWbM4mXzNKC
         Kgc3O6orPsPhj9mNSNVQfNjAK3WU13GsTgAO87adZZaJahRxncrtP4c9Z/zT1QpI7sJM
         lB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858712; x=1772463512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVFRSrlvIGdGmh6nXcU3quee6dziM5MmqPkAm3zDOXg=;
        b=H//IXSji1mvV+WcTpr9R1m7G5lz/zr4FSrnohwLo00rvZA+Z+IRtvH67Gdv3eKPSfb
         IgBcIoFVOWS49Kwlx2GQcsxjqsZsGerV9k2qeIolWEz+nJ11CA6O94HDU5i82ab/KQWZ
         8VRnkdIjCg1d5BVQui3Qt9edIY7exznY6UrsD2id5D3UPi/Xayl8DmJ/2wN4JSEshyjx
         4Lelvi8cacMlfEJZ5OZRaz4/weW/TBPnVjxFzB5AEsyD5qWI3DLc04bKpcE894XdUP46
         EQ872soRaP0R6+0gyeExoy1XitixNdLpv7wyQzR6aYe6byUCK6M5bEtimh8h/j8oPSQN
         IuPw==
X-Forwarded-Encrypted: i=1; AJvYcCUfUTfoaVGlSBM2UePEGLszDhBfw1ObA9zZB4+QvMz8NJXMUFfyGQy1LykY1iJxPKVE1j6+d+hAykbt@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBhmPUMkpgjJHyG0YGObG7+zCTrlDWCLmlhH0/TPV2MFxN2Ch
	p+jYKeOQWZimOrc2Dxg9On7e+aBPEA+nsy2+86jEoqAuD37xtVaklw+3XCKGTklZhj7LGTJ6kQ5
	5jjlgasA2154e/DtHnEMbgxMDID8jSY4=
X-Gm-Gg: AZuq6aJv+UaA/m+tB69temuv9a6ZR4RfW7nm+LKp95On1WHhNfLL7lCE413YauPlJTi
	FBpTiu5iiaRl6rf9rok2C/TbmNhU3O8NXISSmJcf//76qeL5dkOmkx+2I+rqt61eLOaspJYnP37
	Kkjvipqy7N4SR//I+e7VMla2X2mkIfeqqn/PQF0jyrHf7mhfweuve0LrS3oTafDtLkkHnFJ2gRJ
	SbU0rFePi3TfsmsgQv6Q7sFnjIRUkRWDsQa+EfyN+L/h9I3gEtKMnGAsBvUVIpm0Xm3I0I1S2Rt
	S95xbY47Jqx4nh0y7fpSevy9Kpx5Ihol6fCKqPTG
X-Received: by 2002:a17:906:71ca:b0:b8f:7014:48fc with SMTP id
 a640c23a62f3a-b9081b6dc57mr426825666b.57.1771858711914; Mon, 23 Feb 2026
 06:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de>
 <20260222103918.90670-1-ericterminal@gmail.com> <6C330635-430F-408A-8AAE-F79DA2573417@alien8.de>
In-Reply-To: <6C330635-430F-408A-8AAE-F79DA2573417@alien8.de>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Mon, 23 Feb 2026 22:58:20 +0800
X-Gm-Features: AaiRm50sYydhlScvG7rMzkTQG4y4TleL2Ncbci3-hQGrlm5bEKC1DeJie_GBQKM
Message-ID: <CAKNPVZADH3YKKdAostJqZV2U6WT3bqZWetquNHU7y+f7o8Cu-w@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in init_versalnet()
To: Borislav Petkov <bp@alien8.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Tony Luck <tony.luck@intel.com>, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5739-lists,linux-edac=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: 2E4AF1786C6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 9:47=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> And I'd usually say you can take the current diffs, productize them and s=
end them after testing.

Uh, yeah, that=E2=80=99s true =E2=80=94 after all, most of us regular devel=
opers don=E2=80=99t
exactly have an FPGA sitting around at home.

> However, testing is the problem here - I highly doubt you have access to =
the hardware and Shubhrajyoti is probably one of small number of people who=
 can test it.

This is purely a logic bug in the code. What I did was just fix an
error-handling path; it doesn=E2=80=99t change the normal execution flow at
all. The issue itself can be derived through static analysis of the
existing code, so it=E2=80=99s not something that depends on specific hardw=
are
behavior.

> Except that he's not really moving here - this particular issue has been =
outstanding for at least three months.

If the driver isn=E2=80=99t actively maintained=E2=80=A6 well=E2=80=A6 I ca=
n understand that
too. Still, this patch is very low risk, and merging it shouldn=E2=80=99t
really add to your workload. Maybe straightforward logic fixes like
this could be considered based on static review alone? At the very
least, it would help improve the baseline code quality. :)

Anyway, enjoy your vacation.

