Return-Path: <linux-edac+bounces-4348-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C35B02E86
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 05:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEA816ADCD
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14478F54;
	Sun, 13 Jul 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGE+AHk9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05472E36EA;
	Sun, 13 Jul 2025 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752375656; cv=none; b=PI4POut4OmtnkqkY0CM8d8Xq39gg6No0OuZ7+i+SE1wqY8sfUasx4csot1uV9G0aI0JkjnQxAub6kKQdzmT4fZwPOWIBmgrv1iSQEExXkmsCOQd2yMqDogpBk9EQEwOxoDP62+l9LSfI0XsjrMvtkTFYY8WdgKkrwwdQIwL6Ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752375656; c=relaxed/simple;
	bh=V51/Dk+w8f9Eq2cU6nnaYpqKEowxUKUCHwLp9pdwoxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZh0vzuDEJQiI8CklT2qmkDbqUKK53nVeB/5+oTeRokaHVEi7YX1+kqgjPpIMfBqC7oOR1aXgeIziEeS51kr2YZUPU/nMXh/AKd1I8sDyQhbTKq3EJKVMPCGmuGaS+yZhxSbMHhvyFc2onLpH6GjeIv0/OIIBjhVqd9oQXoQ+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGE+AHk9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so2288498fac.0;
        Sat, 12 Jul 2025 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752375654; x=1752980454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PdGl37R4nDghxJm/fbOQi/LfvF8z5Q80ETZEYUUQDU=;
        b=DGE+AHk9IUWYkh7un1FbN2Whriaku/lZPhuz8Qcl6tseadHCP2c4OV/4HzoRWzY/Fw
         DAWz3DvBoS7VkBgzaAJdfjXw0RHTPrdqMOXiaVWVkkEDG18aACSJfRZ1Jqe0HAx0IUaj
         IpOcEbp/Qc4DcQE+lgq9DwALDauZcBva5U/u5C/mYVGAo3Wq3ZlN5/IBcIQNjUSwaq+F
         1DRDLgzDRGc38ay8xMMzRy6S72+yqXnWpaSVnxhkBolt81PfSoFUOMEySltjQSgA0WCo
         49m5aCcy3gu936vLenm+Q0j/w35TvsE6WJOs9ZIepI95kXNlCV8JjJZyuQGX3mse5nGM
         6rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752375654; x=1752980454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PdGl37R4nDghxJm/fbOQi/LfvF8z5Q80ETZEYUUQDU=;
        b=n+DCoBwVLoQe7hkswzho/E5Jg/T0oXUcnyb+QQQkZhobc66f8gj2hsiHYAtXZ0TZB7
         aBOz+Y6fmuZ9acRDGkf51lsFUJI1XFD5vG/LK/KnINbqSkH/Q+mexfOfmpwr7EJZj/98
         f8KfDAsATMcOTCwbcCHEsOgACN/UN0DOPWIVj7KJMHloEFv+wFKz0exttTu8nrTnhsM3
         52v3Dwjr7zEEfP+ciwfv+4/TkgcuQaKOoK2yMi7U7AukGLShmHsQ/O+TBMmEpzG/9eU8
         cDewWUeIqS3cL5uL0CE0KbbrXwFqe9SBXSyJN35L4HwIAX6bZnW4Nz8zTTRcxQo8uHJa
         kAlg==
X-Forwarded-Encrypted: i=1; AJvYcCWE0W8wA/rIPYDVqnfibtu9XJxOvIDCS5Se/876gFW5G7paNtKP97WtG+V3hUgpV/+kifAnzzi8HtFY7do/@vger.kernel.org, AJvYcCXHEnIm8guB7tuPLE14eFlZE6fj6s+SddlwToKypr7p4CplIi0w7xLkaWgQngXEO1wYbtBgQZEdn1Rk@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEqYfYqsjT57byr79J2cPf6YE+C1f5ufcFKZ+8bD0NRdTMkXv
	4gPirsnjuTbUeSK36E/mHm/q35DkxxmjAkzrBh4PrONC8DZMxLLBuXGyWyXp/u5inrBzkbsU2hk
	I9lSYoEW8LMsvbbHK90svZ7DZZh7kjTw=
X-Gm-Gg: ASbGnctrBOKvupakjbXF+z50wk841lM3Hry0khooshhiJ5Ui00LtU/qoXTHdVrco3Og
	YIw3PT97neNIyThJSXBSqE4Bljki/nWfRKTqgzVWTFA/RW3AhtoGRNTenoAY29JG+cz6UuDIhvZ
	7Y8xFETdDNhUWOfRvIyeUwNHT6MXU1H8ZVucMX9bnH814gsVqdp8tODF+6Ag3peMQtC5AM4oWbV
	9M4kQ==
X-Google-Smtp-Source: AGHT+IHRGw12dKUoyB08u7s2mpuwKF2CZ1M0AnfBKVYpPu1Oap3NCI0Q+8yOUrbJ55gJZUC/tU0Lp7j4U5NIsQE4X7U=
X-Received: by 2002:a05:6870:e069:b0:2e8:755d:b4e9 with SMTP id
 586e51a60fabf-2ff2640878bmr4481430fac.1.1752375653641; Sat, 12 Jul 2025
 20:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
 <CY8PR11MB71349230AB9CF3347D333AC48948A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CANZ3JQQdNGjzkAY-VUbs22sveHCsvCtgVkUApfTYFG7wGw1gCg@mail.gmail.com>
 <CY8PR11MB713497AF56976DEFD1B8EB3E894BA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB608322D580CC951F58A03B1DFC4BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608322D580CC951F58A03B1DFC4BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Sun, 13 Jul 2025 11:00:41 +0800
X-Gm-Features: Ac12FXyNarOwguMk1x4leSSje2Pq2pcCsoXdZfM3FYMwcZmVhXnasWKCR1mCW7Q
Message-ID: <CANZ3JQSkugGg97D5iLRo+ou7BjRRtK-5BCozZ=OOtfGz=jZVjw@mail.gmail.com>
Subject: Re: We found a bug in skx_common.c for the latest linux
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ve sent the patch as requested. Please check and let me know if
anything needs to be adjusted.

Thanks for your time and guidance.

Best regards,
Haoran Wang

On Fri, Jul 11, 2025 at 11:24=E2=80=AFPM Luck, Tony <tony.luck@intel.com> w=
rote:
>
> > Although there isn't a real *issue" you described here in the {skx, i10=
nm}_edac driver,
> > it seems still worthwhile to replace snprintf() with scnprintf() to enh=
ance code robustness.
> >
> >     - snprintf() returns the would-be-output size.
> >
> >     - scnprintf() returns the actual number of characters written to th=
e buffer.
> >                           This ensures the subsequent calls do not exce=
ed the buffer limit,
> >                           particularly in code like: len +=3D scnprintf=
(buf+len, SIZE - len, ...)
> >
> > It's OK to me that Haoran replaces snprintf() with scnprintf() and appl=
ies these changes to
> > the files: skx_common.c, skx_base.c,  and i10nm_base.c as well.
> >
> > @Luck, Tony, do you agree with Haoran replacing snprintf() with scnprin=
tf()
> > even though no issues are currently occurring in the {skx,i10nm}_edac d=
rivers?
>
> Agreed. It would be a pain to debug if the first snprintf() to the buffer=
 did overflow.
> So code robustness is important.
>
> Haoran: Please send a properly formatted patch with your "Signed-off-by:"=
 line
> included.  You've provided plenty of explanation in this e-mail thread (w=
hich
> I'll "Link:" when I commit. So it's OK to be quite terse in the commit me=
ssage.
>
> Something like:
>
>   snprintf() is fragile when its return value will be used to append addi=
tional data
>   to a buffer. Use scnprintf() instead.
>
> -Tony

