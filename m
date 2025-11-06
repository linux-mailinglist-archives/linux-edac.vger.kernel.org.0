Return-Path: <linux-edac+bounces-5359-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D56C3A76B
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9ECA4EEA37
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5A3074B1;
	Thu,  6 Nov 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BqmcGAbI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942C278779
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427048; cv=none; b=BU0qYOM8mQgBKGCljsy5DDURoy7VUU5vpLLG9uz0Lk/kR77zJduE50t5eQ+PNOexFp8DhWKEg2hFZHsqcw85GLGch+PwKtuW8ra1Q4pZ8NMXK8/LkoaMpY0oWr18kEWUg0fBLHzG0Bf8zLpvlBgH1agaltJduL4cuGXSi1vSSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427048; c=relaxed/simple;
	bh=+GeJ8NmKQkLawbH/LMVrmrdydLjiycqpLHBxv2MYx9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYnkaVdByHTi2FjMaIZZIFMsXiA4zEwTsXXWMJvyTqOuSGdxLDjRkKk8MR08IMYSnJWnKZ3NYRt+LEHnVftx2xIS0ZwC5+KqDQWXqswRPEEQbreX8cmP+oNsBDVA5svo0n4YPk7L7s990zDeaGBNxFKMBzJMR8ATe25/3TGGMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BqmcGAbI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592ee9a16adso1153807e87.0
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 03:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762427042; x=1763031842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyHaZAbJ53jyXeWbX+O1Xs3tfYFAmudzKPogsGg5xTs=;
        b=BqmcGAbI+LT59HfN9ZmXOspf9yAWEWx5uXYAQK/N4OoZA+CDeX3fiH8L9YZT+2ITx/
         C00phDGXeG0uUiV3tFvl1B9wvhj1UH8tA5I9FCAgpRCIpHEgb+QTMFQqimxcgcaZp+WT
         HK0Jn2z8qHu5qQFM0x+XAS0liLZwV4rXLHwExiQnK7n6sWQ20IY2Ffp3vnJad4bOEuTC
         cjhum6UB0M739hq7F1PGkj7BfvPQh3BjmUqh017CTMGjdTN+nx7aT4zIbrSouxNmtKgy
         7yXKZbAQEqsW7bBDan8iFsfh0zyH3EDNgHgqcSWJgW5MVs+/OfzI43Dvfb7Q/QdUQxMk
         Tn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427042; x=1763031842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyHaZAbJ53jyXeWbX+O1Xs3tfYFAmudzKPogsGg5xTs=;
        b=pNu6oW3Ri3oKR3BIf9L+z9lgGpxSU5uw57gim541idXue0iS4J5A311UmmZbZK2rQF
         3eoe0Atzm70H0Y/wIISPsSC902s1fZz8yAB6BQIU1KpbY0mZfJ5euCdRow8u1RHxPi3Q
         gTHLHJPmHhw3+U4JWOv81XkQeGQLdKkfTNCFS1Yv75PGCCbinM9E2yNf53nkzso+W3nS
         RK2A4RmofuzMFnrXfhKW6ORsnnzSVN+ClUvxYeEWq+112102VDoI0a+Nrxy6R7syb9Qf
         Bq0bNOp7C+wnv4RgIz4c6v3YnT4fRGY58AQC8DooyMwxPD7FR9PbYKgewijo2cDuqOZm
         /uPA==
X-Forwarded-Encrypted: i=1; AJvYcCW1vdkoXrfCAdZ9/iQPVj/Nuc6AVx597G57ztkVVl8DUZnicNk8KEGqqtwD0XoLa33Ritqjv3LrTqVl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg33Qrkdn0bNsk+iZ57jWl2rfMxcF3ZTgCVmPcI2ki2ovWMao9
	l5ExCBXEDQfZfMm5UxY5IP+fJvdPD0B5x5vJyB1SCBuytKc3rN5l4IKv+q2Abazz3bJTa3UrEbn
	y29uQD51gGvidlP8o/E1NdPPwuSDALgvlu2GlWHfNzA==
X-Gm-Gg: ASbGncsi9vbLrcZRgNiiErHnslZGeYf6p2oX7UYaR93Cy1hdmpa2oU4LYlIZgLORPLc
	RQITzaJqpRnHvtFCJ6DuMoQ9ZE89R7es1/i+UOzvt//Y4shkg/4wghZpsdEdl/2lhLIiJTYc+1p
	IjheQZa5hfbo1H2JI545w1WaZDr5kQNFDHmn3kPhTyM75u8iKxQKz8Ik9SFyiLRQlfPIuSs4xmv
	1ksl1seMmr9V/5M+Qf72W5lktX3w3qbfVnyv/ZvQaJr4VcW5qzaXK+GkP01VCZAAZGP8BIohr4g
	pqL0vp9oFK5LdMq6AQ==
X-Google-Smtp-Source: AGHT+IHNS+lV8DDaPEBqqaz8m9DQ1tr37iv//49lVHU47CIoDVlu01s4MTSMDavSRxporI0IE2zgko0r5MzlKSRbmvo=
X-Received: by 2002:a05:6512:61b3:b0:592:fb56:f2be with SMTP id
 2adb3069b0e04-5943d7dd243mr2232093e87.49.1762427042386; Thu, 06 Nov 2025
 03:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local> <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local> <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
 <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local>
In-Reply-To: <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 12:03:51 +0100
X-Gm-Features: AWmQ_bkqO5AWnwijQqvBv076aCG27zkaFUfGIMNS6UQEH9zKSWwtFXQwBUx15T0
Message-ID: <CAAofZF7cz_F9qgr7WqbORwH5iMuAO9f0SkWRQxQ4ns4o2X_xJA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:49=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Nov 06, 2025 at 10:17:18AM +0100, Marco Crivellari wrote:
> > It's just a "rename" from system_wq to system_percpu_wq.
>
> So why don't you call it that?
>
> Instead of beating around the bush and confusing me? :-)
>
> IOW, just do this:
>
> "Rename system_wq to system_percpu_wq as part of workqueue refactoring.
>
> For more details see the Link tag below.
>
> ...
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de"
>
> And now all those people who are interested in the details can go look it=
 up.

I was torn between "replace" and "rename", because there is a new workqueue=
,
not only a rename of the old one, because for now it is still existing. :-)

BTW,  thanks for your advice, I will send the v2 improving the commit log!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

