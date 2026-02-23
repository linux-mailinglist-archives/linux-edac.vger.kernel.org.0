Return-Path: <linux-edac+bounces-5735-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHXxCF0onGl1AAQAu9opvQ
	(envelope-from <linux-edac+bounces-5735-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 11:13:49 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E43174A30
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 11:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B75C630AA6FF
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0C35C19C;
	Mon, 23 Feb 2026 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFun3J7E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0135B656
	for <linux-edac@vger.kernel.org>; Mon, 23 Feb 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841297; cv=pass; b=MxUf/WhnQm8U1C3hVfDUCHROm78NNe+vZ7P70voNEw40CtPM2bIj4aXkRD460nW5MixU69H4uMYwgEXwZVRxNU2e7cyJZxfRJTDfn1e2IT/bmJ+6/yEvCndZZO2V/JWk7HVaSBgn8X/T9oH66zayoCR1XR7lAPNIQmrv6mLEUpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841297; c=relaxed/simple;
	bh=ORbmNbV2VFa1hM9mI8/2qwaiF2bpLJyT/0PM8woNTOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdrQiNkGrJCww9+wHjX1AVRUEg4GdfjqtPUUVVl0HFRAd25sJJXFNsASFNf+R5JQL9RFYzaAuhSLjx6uzjyjAezt1koXKwcTjwRcMhLlAIDxC/o0N00/Sq6iVwjnXmUQbMeulwbkgb+WjH/ElWvEhprei1QscFB9wPHZZanZgo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFun3J7E; arc=pass smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso8273313a12.0
        for <linux-edac@vger.kernel.org>; Mon, 23 Feb 2026 02:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771841294; cv=none;
        d=google.com; s=arc-20240605;
        b=Hoz9ijrxlBx/aJ/ojS3VfTxbMSMulBFHtyriwos1M9qftkXgsYPydaz9PV0csq/xy+
         3SvGOPKf8iufRai5p68Fon/YJEnQapSWkQw4uMVzTyM7NJQuiJ/+lCBLmdX2c81vfjYV
         pIeJq4lGG/WW+jeJ462FAtFnktjXqe2DiWJ5x4XJrVLzf2rarUH7n/SQTTlNxtQsqdsK
         NNkhOfqz/gPOcZxWReH0xXqUyA93R82FRhl7+J/QsetaSyI5uCEerE2k2BMQ0B61tSSU
         Zs15qvMjQebSizhBOKOA1rHIa7/NWtvwSm4N9SF/g9fxDd5gZNp4kBrwE8xx7b1W2jA8
         jrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ORbmNbV2VFa1hM9mI8/2qwaiF2bpLJyT/0PM8woNTOc=;
        fh=mRFNJ6gtvuosNsgqX8rZg0MBI4ocOqZI6GgqfcJ+u+8=;
        b=ZKblrOUzuZKbaasioTx6QheMQo16kAIoeG/0PIb23tkGnzRTrnquKgQFfIwLMtylO4
         w7ylKFAlRdt7e3xiztcbkB3s6axMrTblqf4COoPcruR3r1JYo1zTRCaz49y8SOQ08KjK
         8vvsNRegfPeDvq0PAsz5gNKVpwKEavaRCha5A5djZDqGHrTlG0YN6LKu0fLkdqjwl5ZF
         WQKDKIvDMmHqzGj0Ttcl9LW9pvTDo1DRDVvIc5GUMc0xB2fpX0ZnVZHxGiQ2V7RPtOOL
         Aqc5hd9A+BctwvYTE2d1DjxLzCm4DD8QJE2+sraph1+XVS/D0/QhdrJZJ97fRdwmvnvl
         WV3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841294; x=1772446094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORbmNbV2VFa1hM9mI8/2qwaiF2bpLJyT/0PM8woNTOc=;
        b=UFun3J7EmjStBaSXk16KPshWVQCoSnNa3Tgv/ndyvT6xfrdKrZAT1itIPXYUw6E9Rm
         4cJZRBej3CTxuCu7Y5OPltVm44TroIZBNLeat1A2NIkA360hna4dYc7xRlIAKOMkJndb
         6xezUjcRw0Iw7Ud+1qcjhEdEAoKrZjZJSLZiZs66pUukz3285qff+TMd16nIl/SiZMYx
         T25L1fPwl3WozyIibefxRmqVdkEIRZqHL0+LPKd2fWnbAbC2M9fKbqQgd/uWz4fcgw7X
         +7+wyakhaTJtQ5H0yORQIXhfV61+Aj3g/YW6MUjpFD83/TjUj9nl7QX3BCpKSRavNyxU
         9ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841294; x=1772446094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ORbmNbV2VFa1hM9mI8/2qwaiF2bpLJyT/0PM8woNTOc=;
        b=IB2x6hTens8amfPetTW9Y1VhpEITEvStPqD1fKaRip3fF7/g2NP7h/8BOBqhgaej9x
         plK910cF7VHOjSTzy9n7R1Bz6GFpCnOKkfIK1Su00eG7aqhEGy/Q2+buXNIkLmr2vmuo
         5glX4BL360zKF1iFw4a5nAVcwa2yZGM8v5BHHS28OqGIppINmBhvigjuNvruuBlJyYr9
         4VqM3xkz/iigap2d9pyhQKpxjS0sUH6LdPnRDd6QjI6x8HCIwrry+GaZjdZKyE14FtFK
         KJcs0/jzQ9a/NpKKvSffzaKOAkyOGpjqHFPXvnbVhvWsoShq/kGaBSc1I/2LpAXEJeLX
         Mmnw==
X-Forwarded-Encrypted: i=1; AJvYcCXSGhezG3nIt6H1lBBLCPi0NXYwbXHx+MgtkkWO7o0WGZ8T0bi5fXqFvmZYuk34Zr+s9/ztDWr9eRfp@vger.kernel.org
X-Gm-Message-State: AOJu0YzEssttxTju7IM+C8oUN5xs/si4QPoj8D/38YndX7scR0kuHlq8
	1YaM8rukvV64YIscXaemZSP9rKz/B03PpC49IWO9+SHVajsrSxWFRuX4bTkKXSuO4N46WSFceW+
	iDkFHQnojyVkpqgvShLJhVaYuj8LgscA=
X-Gm-Gg: AZuq6aKkzel4u8j+gz7a415eSgjgz9LdfUZxVWAG2vvSjNB52BqS+0Lfq3R0p+iO96H
	l/AE0flBqrmVYU7MwD6U+0zJv95E2n/OiohCiO+h4u4bo8vh6DE8TEQKcLUFWrLgWxPFRuZzM3/
	SupjDbVgdJpxZ4LVXyXNbpdHKUYnxS2VEgiMnBNyZPQRYNyKQ00mfg2L+XZI64Ek6oplsCXK464
	QtFLl/07lKC09upw7b8MD3CJ/3SHnrkXdgJKik1w8LY6gSXa+EN27LQ0h7CCUgojH4eTpK/8Mbo
	UCx9XgZx1poATuxWrbeQJAlw3v7fwLUFwsxkVoy/
X-Received: by 2002:a17:907:9602:b0:b8f:c684:db37 with SMTP id
 a640c23a62f3a-b9080f13fafmr477188266b.9.1771841294156; Mon, 23 Feb 2026
 02:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKNPVZB1xhRnZ-DaEAWE3qn0EpdS9_q3w2xZKQmS0vhkXtaGvA@mail.gmail.com>
 <177183685191.2552489.7239740491321631280@Ubuntu-2204-jammy-amd64-base>
In-Reply-To: <177183685191.2552489.7239740491321631280@Ubuntu-2204-jammy-amd64-base>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Mon, 23 Feb 2026 18:08:02 +0800
X-Gm-Features: AaiRm53fU1gRV3hRybHwB2wB0wxQc0cy_lPicU1g2ctQT8akzZ0IqaGkZ0xVi9c
Message-ID: <CAKNPVZAeEWB6Q0VRB7099s4xtLZXq9gqDnrfeYHkfFv9pEjaag@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5735-lists,linux-edac=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 42E43174A30
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:54=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> In my not-so-short experience no new submitter just reads all of the subm=
itting-patches document without complaining at least a little and
> replies with a new version of the patch - all that in three hours, and al=
l that in way too polished English.

To explain the "way too polished English": English is not my native
language. Because I want to show proper respect to the kernel
community, I relied on translation and grammar tools to make sure my
replies were polite and appropriate. That is why the text might look
artificially perfect.

As for not complaining: I don't know how other submitters do it, but
as a newcomer, I honestly didn't dare to complain on the mailing list.
I simply assumed that complaining would leave a bad impression and
might get my patch rejected. So I just tried my best to read the
documentation and follow the rules as quickly as possible.

Regarding the speed of sending a "new version" in three hours: it
wasn't a rewrite of the patch. I merely updated the Signed-off-by tag
to my real name, re-signed it with patatt, and sent it out. The code
itself didn't change at all, which is why it was fast.

> If I look at the actual diff, am I going to find a bunch of nonsensical A=
I slop and am I going to waste my time talking to an AI bot as a result?

If I were a fully automated AI bot, I probably wouldn't have made the
very human mistakes of top-posting and forgetting to "Reply-to-all" in
my email before the last one. :)

 I completely understand your concern about AI-generated spam.
However, the NULL pointer dereferences and memory leaks in
init_versalnet() are genuine logical flaws. I hope you can take a
brief moment to review the actual v2 diff. If there is any technical
issue with my code, I am more than happy to learn and correct it.

Best regards,

Yufan Chen (Eric Terminal)

