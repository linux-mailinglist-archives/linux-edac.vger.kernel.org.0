Return-Path: <linux-edac+bounces-758-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA730878CFC
	for <lists+linux-edac@lfdr.de>; Tue, 12 Mar 2024 03:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA7C1F21EC5
	for <lists+linux-edac@lfdr.de>; Tue, 12 Mar 2024 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2E53BE;
	Tue, 12 Mar 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IT7k+2Bc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97B811
	for <linux-edac@vger.kernel.org>; Tue, 12 Mar 2024 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210329; cv=none; b=ecKLeFj3Fku8W/UcqD1+ih/1yl2oGPab2jj62Iyki0afxyTFFUYvJXJCIVRnO8VHwlweRf43gjML7HVhpbe1fxDc+tz9OnM2Mwngc9SyOMQ6/psWuCyBRKHHcZDKg8iWaXhSAnorICAB+XUjt/NuVvrYBqjQopwcylfedgAH2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210329; c=relaxed/simple;
	bh=FOFhFlZwDYaYZJ78MEhwu5CQoQ5L1/MROugnSq9349Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U35L//+vLF3KELgvWVkK9Bdwix8Q6rezm2Zd/TBRooe0XHvbvMIxiBJd+ZkxhkEvEcq1MnUKBMKs4zqWQ2+DuRrxbzG1Z3Ggga9YaXZPlt/4iokszGpgKwwj+cog40vBUGl+ruB+WTdpzku0eRCy88hgqgX+e5vf0wy86YV6jYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IT7k+2Bc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4429c556efso404722066b.0
        for <linux-edac@vger.kernel.org>; Mon, 11 Mar 2024 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710210326; x=1710815126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n9I8hxzcgp3Ln+LOJaI0E00AHAUMAJV7Win5EAVVObg=;
        b=IT7k+2BcTffP6MJ7BD2NNAbIXr5Xjes7Cg776YKaCCnH3V0KQlcbTN8OH5SrKXwkfs
         cZ8C7uq8do9kXhzV7dfsl91Gko5aGin69HGzuRf9Pg/FYeDMCIY5OUJ2A0Bt+SAFOg9E
         9076kO5Y+FtQFvyrpILfZJH9e163SWGpmN+kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710210326; x=1710815126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9I8hxzcgp3Ln+LOJaI0E00AHAUMAJV7Win5EAVVObg=;
        b=C4M3wWQa4l6yH1oSm73zXefX40EIEozuLLkqInnY1P21Kl9Ng4Wkjtqm4q3xmUuW43
         I28uHYTJH0BTyvmQnuNsQzfqBCrzhB9NwJHuFw0elt0YKp55LCx/aGekjuCgTQc4fzQO
         gQodGwkNtrcH34URfdb6vW4WBuRyXWvXHRdChjeVVgXL5PugMl6EbqwS9intBWp7Npt8
         uRCB2XDTyWouB5mWMfgej9l3NTGvHhiudXTdZttT2/x0Z2eDDRHb2aOuZ3v3wufbE7gy
         yDCvy26nerkp3vNN4SHW1TQSoLLXqDJpotVXOR7qt1Xy5eW6EErl487RaRR5gFI/9nHP
         ZBvA==
X-Forwarded-Encrypted: i=1; AJvYcCVB+sZzTXKjrUyeLcTkXP2rPm1rcM0yYZWxRwpJV2HAn+RK6n4QQEJJ74GOcSLL6Ta7O90L0m6G/BsjCojhSRx0vwF80R2AqrAkcg==
X-Gm-Message-State: AOJu0YzevpywY+cNWhWnsVv10GMyJi819o5kfkzZlTUaf5MIpSj2V7Ps
	zirh0lNM1LwT9RHAdbC6Oqx0f7OsjndPCdQky3PTuMHqRQNpj6+CPnwnaa7Qyd/GZp62PfUrGLc
	X2AOlrQ==
X-Google-Smtp-Source: AGHT+IEye70/d820yE4sF8/pnsSrdgPWC48bWLX7qJebzzVmQ+a4NwXxcCVoUB9fxWl+g1Z3Mbpbqg==
X-Received: by 2002:a17:906:99cd:b0:a46:198c:e219 with SMTP id s13-20020a17090699cd00b00a46198ce219mr3818251ejn.36.1710210325931;
        Mon, 11 Mar 2024 19:25:25 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id bk15-20020a170906b0cf00b00a4617dfc36bsm2360851ejb.178.2024.03.11.19.25.25
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 19:25:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso4973306a12.2
        for <linux-edac@vger.kernel.org>; Mon, 11 Mar 2024 19:25:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFW01VkrZQS9GA1VRzkCU1Oh+27RsrsRHKx9vE0b8vJnMlW9cUdUJw+0tJd6ooJ+CT0WXTx1bkGYwN1Jhi5axbRX2FdIHSEqj2rQ==
X-Received: by 2002:a17:906:1715:b0:a45:8a13:447f with SMTP id
 c21-20020a170906171500b00a458a13447fmr4518070eje.5.1710210324748; Mon, 11 Mar
 2024 19:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com> <a4bdcf74-5c6f-4483-a4f0-8ad6558a3c8d@infradead.org>
In-Reply-To: <a4bdcf74-5c6f-4483-a4f0-8ad6558a3c8d@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 19:25:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUPvds75HLJb98ZNXdZe4rTQn0wK33OQYYfQBqxTjfhw@mail.gmail.com>
Message-ID: <CAHk-=wiUPvds75HLJb98ZNXdZe4rTQn0wK33OQYYfQBqxTjfhw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.9
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, 
	linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 19:24, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> and there's an extra/trailing ';'.

Ayup, I fixed that too while I was in there anyway.

              Linus

