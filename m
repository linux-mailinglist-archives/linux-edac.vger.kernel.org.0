Return-Path: <linux-edac+bounces-5737-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAXiNZUxnGkKAgQAu9opvQ
	(envelope-from <linux-edac+bounces-5737-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 11:53:09 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC417528F
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 11:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EAF330027EC
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107D3502A9;
	Mon, 23 Feb 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWRiUyOm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F646139D0A
	for <linux-edac@vger.kernel.org>; Mon, 23 Feb 2026 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843986; cv=pass; b=iz3GXdrtNlbLorTWb4nAvv+xbsDS7GGKjx6M70LJgy63t0soMfHyR0z2NfRBuIG2mpkx8NKMmOLkCOQaW56arrln/ffpcco8worHjB1yIkSSBX3r7TabbyCU7VtWdBtpiLd2fGRLhnAIFNUa7rIVSAfs4Tn1tqtbYE5NGpVRPn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843986; c=relaxed/simple;
	bh=qj7SsUuA8Pf7Oqvn8EVKZG5z5K9P6SvhUUT790Sont8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7BbLnC/eG7s3Zc51TGLW3fBakNcv7zHJ/tC8yE79arLPxhDzjbivNeLuVmFgXqMs+TZJAzMmPG9r+YnNvXXw9J8jUwehsgTAmlMiFMIPxvxiMBreKUCrmXfTOsER+OoKkgEfADbGXuekYlvhkMYt/JA5wz5XMRq0ENORJhZdZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWRiUyOm; arc=pass smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8845cb5862so684457466b.3
        for <linux-edac@vger.kernel.org>; Mon, 23 Feb 2026 02:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771843984; cv=none;
        d=google.com; s=arc-20240605;
        b=izV8oETDEv1zTxy1xjecb0qfkWV8KxCwtdlcJ1StISKU4xT7Lmr8e3JZ7vLnMEaVcO
         f5a1uvZ3cNMsYafqmBw8EnjfdxyrEuRYNSj9I+6qhWpV6sbtzjY1U32789HFNw1nlLvm
         BHpxc3UrWPZLOa+vbRGlqI3ZFVSqIXTr6ehoTJwOXi7+I6ZN+NljyZEjU4aBaW1yjGhU
         O98iUtBXZ/s9xyC00JGdqwpqbACbnLPOHDC840l6YB2nAEalWV40dLEoqG7s6vW1ULTn
         K5SMSkdmFcXlv9vOc/q0SL4GDzs9HCHswRtQVC+tH0LU3yugCuVEtE5q+XU2Blm+InLz
         RNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qj7SsUuA8Pf7Oqvn8EVKZG5z5K9P6SvhUUT790Sont8=;
        fh=ooJsWV9LCfa6m8WDN36M3waD1PNuckoxQkFXAK7FgXg=;
        b=e+KwU13iWJKBUxqmWz2ew+E95rmmFraM61o+ueg0aI3AP74oFNWxZsJEfUHkZwqAFJ
         8PZOG8Z8KnCDEn5fA//hNeKVGXxPWnqh4m6A8fZjeVT03BteFFpTs+LrsxPwA51eINq5
         BAEPKUwxeGlOq53Sf0qsJ18qfARJb8pHpWMQbJI3RMc0mOoYkVtfGotHfO4nu6b3ZvMG
         ZLMz27DbvYgwvU1ADEem0nBJRzz/jRj9ZBM2iF/EwEJccW7Dl373RnnYMp/qT1N03tn8
         w/PesTDXyO8iIXNAbJ/kLswpla2+FlNshNOeKkWVxhF2o8cDoPTHLuHDhYXnXtqbEmiI
         8QEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771843984; x=1772448784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj7SsUuA8Pf7Oqvn8EVKZG5z5K9P6SvhUUT790Sont8=;
        b=fWRiUyOmThwi0jj4SQPWDUGafbeo2vCgwH44Dhj3BmRkbpaQwUJnOV3S4x7IXpVFS5
         8K4B+1hLONHzpxggCcS0geuE0uH1JhoQ97a2fJtl0dGI179GIYAXAcce7RiAL1Qo3acN
         ATpvpG3npO6MDc+q3kk5DrjeBvLcIeqRKb+OHJR661ZCnCppUpfwCBimaMqlVZIW2Gse
         kpBWZLPl412ae0SDIFadpvisWKJ6LkxM4xOJ9mM8lZXzSjufwEDdtg8hzzXs0gMyY+mH
         8msmOLOxBRXFi7zQP1XxAkgk+8v2YmjA5/gbhTgGxGHUxV8zjCGD/jylmgY01qkTaC1q
         GQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771843984; x=1772448784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj7SsUuA8Pf7Oqvn8EVKZG5z5K9P6SvhUUT790Sont8=;
        b=cw8cL/8t6SRi409TW/Hq6f8YFzcYU/YOMs3/jmaGNxkJLBVMXu/ral/pgfM38WwhI3
         2shqfhsTgyfSQxoz2Efg0WGHG8Ogd5f4fILH5uKjeHxjqngyLJ5o/zyim3E8/9Tw5739
         cAZVaQvi0Htcbn9HOf/5ImexcggqsYdQnQZyYX/m2RfDfs7FQP2HscEN99+j95OA5+6v
         +YGdZ16zDwv3PLT2Pl6CkfqWb6MmK3NRAT2DJfyNkvuYQoKhEDB3OCZu+o0G9IE5b95k
         WAXly4SgtWIwTsdcLT7RPn2F5NUKUQTTNzXKslvXbnUtDGPrXISqc4UoPFMnKBu6Fw1V
         wG1A==
X-Forwarded-Encrypted: i=1; AJvYcCUC2yaG+lmNK4NzHjHVUvV61IAUWz3wENQb2VTA6eWbLvr8nwa/SoVkV+OfutrNFCTK0OmaoIpU5hTs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XMu3sBAMo77pLqVTLuoJibN/mm/Mm6N/utxgqO/qwxGd2qdx
	to7LQ6dILBhwmJi8XlxLMh4MneGvGQp/VE79jNHscCqTzOO+0mr93z5AywkkosbfxXpvXCxstOt
	RwNIamLBq66Zh009GVCjViYuWbNVdNB+VIh+x6OyUov1SpMDfgw==
X-Gm-Gg: AZuq6aJ6cwZvEH7ATkY9QnEqmCkMc2mDVJwiJS+wTVin/YwGgtJ78vve7+G+ioNsEag
	FwbNklpaloU/E0OGT8Pc3ToSvIu5Dl7d+4y/BVezpNmqrPeo6278bkBQccNKGL6bkGsMR9qtK0O
	Q6iZNZz9HjKllgTnVMxha4wkkBOL3sckGXUSsGE7lBnhUxfNTKikWFlQb90PppI+RsLtpBvH/BR
	+hAH/bjChJPrQTWvxVJ00f6Tx/gInotsJ8P0OhMWajOwzaOYYNYeqgQVI48ASN3TVOAT6YIWEZD
	ovQnW5M1ghDnFF8/LKO5SScFTbCru1zw4Itl17M/MRii4PRfn2s=
X-Received: by 2002:a17:907:9603:b0:b88:20c0:d378 with SMTP id
 a640c23a62f3a-b9081a2ce4fmr497543466b.20.1771843983469; Mon, 23 Feb 2026
 02:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKNPVZB1xhRnZ-DaEAWE3qn0EpdS9_q3w2xZKQmS0vhkXtaGvA@mail.gmail.com>
 <177183685191.2552489.7239740491321631280@Ubuntu-2204-jammy-amd64-base>
 <CAKNPVZAeEWB6Q0VRB7099s4xtLZXq9gqDnrfeYHkfFv9pEjaag@mail.gmail.com> <A0F02AA6-0ADE-4C05-92A8-240C3F538066@alien8.de>
In-Reply-To: <A0F02AA6-0ADE-4C05-92A8-240C3F538066@alien8.de>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Mon, 23 Feb 2026 18:52:51 +0800
X-Gm-Features: AaiRm51neqpU5BZaoGy3_WPRtaoVxOX7z-7mjjussvFBNTsXnvhw2A-bmUdCR0A
Message-ID: <CAKNPVZBwYLVxf17eByehbBXf0dN6OReuFxat_iV1ifub1rpSQg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in init_versalnet()
To: Borislav Petkov <bp@alien8.de>
Cc: shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org, 
	tony.luck@intel.com, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5737-lists,linux-edac=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17FC417528F
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 6:41=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> So you are using some AI to generate your mails? You should state that in=
 your commit message.

Okay, I get it. I indeed used AI to polish my emails... it even
deleted all my emojis. If I wrote directly, it would probably sound
like this. After all, my own English isn't as "inspired" as the AI's.

Do I need to resubmit and declare this in the commit message?

