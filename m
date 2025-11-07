Return-Path: <linux-edac+bounces-5413-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04163C4006F
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83205349C69
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C232C0F6F;
	Fri,  7 Nov 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eRH5NVAb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18092264A9D
	for <linux-edac@vger.kernel.org>; Fri,  7 Nov 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520844; cv=none; b=gnGc4cOBHgUsg/AKdBjlvueVTQYQu3oQAUciXu1UJNhx2Vcmg8zvoAZduask4XfFSJyMKsyvToKx8O8X3VPW9QpiaVCA80cyP3+vmuI0JoBr5vNwZ37lxzlybdmRJdKzUfYqpfUD7p4deUwL/ETBfSfI+Awb4ANyYrKVNfVhrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520844; c=relaxed/simple;
	bh=HADGe1N2jHvqEsKvSITbCgDgSkgmU79zj+5Dduwse0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GO4Ps0aPgMMdD/uAMvj45SbvT3CH5xu23fn8Ol4eB84oTDhYqahwBpeoMkGksJ2CGIIc65xADo/tdA08XMW14f3uucCjCZF5/stCB5PUw9KAvRWUo9gOZpwnQrpH4Sx3CXIzcLiesvtdQNP96SSYOx8/8uJNpeaMdWQxJV2aseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eRH5NVAb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a2d9cf22aso6531671fa.1
        for <linux-edac@vger.kernel.org>; Fri, 07 Nov 2025 05:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762520840; x=1763125640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HADGe1N2jHvqEsKvSITbCgDgSkgmU79zj+5Dduwse0M=;
        b=eRH5NVAbPZ3HhOS2wmeNTIgx9sWt+a/BP/tBjZMX9VlL9qcU7cKNtQ/bgEJC0PeFrp
         2OyJBeedSADo+1MyoDh9S25v6lnadV2923LKH0WbGl/ZUl2YMbtB2CskfArt1uUGGxGL
         JMxMFbH1Kx2MdHJG+IeUhbgVqiBC8OQw1+FfI9qlEbjf3TS4uEQU6we1gjMdWTHjsRoJ
         +AMdpI6IE884Sof+DfOSZlv1XERvbn8nx3yE8ig+vEH7tZadPSqOFoIplRqiltlOASf8
         FWYffY/XJ1hujEUG5NqH26Oztqcbuzf14mRdMYvRcmWjdo+6I6uxV36U3TcFE8t2rxIk
         uDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520840; x=1763125640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HADGe1N2jHvqEsKvSITbCgDgSkgmU79zj+5Dduwse0M=;
        b=Lgqbxa/B2cvu+blM3CznP0mwPxKiXisiweztGop2lIJeUKCDeNfh8sJOX/nsnGradN
         MxMa7+Vpr6gLz/3R4+n164s6DnqFTBqghI/PKVJZyFVFf0pgL7ByiyleVKOIOIc3HAOk
         hOplXwxW57nLfJuU7P0ETXHPA1ydM0gMOiVCPgkdZ/Yo8FB3w23kYV9AnQw2q34rbxe/
         BiiCYA7hE1XfKGPamEc5Bc8eHquJ9kRk8D5YPSKpVenL6mSjMC6dNkhIVmVISWtrG73G
         yEKHR9gbzKwaXfDg8qx9hXRv6ypWD5lQ7N0Me7bvLaqIybUFmWnW7Jv0ahOfdZIA7Cou
         ht2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGjYNq5eQyAa2rLtNjekvd/PGONbo4l+OJC+i176CH40U8CA4MvzNeu8rOR7hHPpl8qmmqLsXlh7aU@vger.kernel.org
X-Gm-Message-State: AOJu0YzNd5CZABtcoWg7E8/zrlk9gP0S+vSfTMk3TQPALOv1Wxe7GMp/
	9kQcc3qPYNUuzRTzT2DI1KmzafikKIGXxLbpemnnTe7N8OWBppqcBdETSPnjzOlUaE/5gga0Q7f
	bgcSWw/OrE8QoAiOwpuN+Kc92uLifiGx1EftzQNMOmq8CnnelVQpX
X-Gm-Gg: ASbGncsDJaKLzXxgO7JVI4vTUBi14UP9K4AQPJ0mBpSROLlezq/3If0Xnpc1v1DuLkm
	LraV3/oW+S7cKzinmdbrocmNniTudyZG4ldMfCNHdUrBbk4dySQdpZ7VdM5Bk1H4W/382aNkC6b
	29PDqEB0phT4vcx7KFQccclSYh+I5KL/Aj6tc8D47vZqhixNL8e//nZU39FqWfsWPKXljdYCq0K
	7O6wti51MykbfGHAQPgog1VgLqx0NIOA/wmJxMI38XlTukBJpCxvn9ZKnutGpUcaXiT6Q4c+0NV
	PNf9ScbW0jw8/B/ljjLof9TIew1V
X-Google-Smtp-Source: AGHT+IFl18SFhedv0/kCPQK6EPqV+HOejUCqpq+rV9VFd261NPF57ZXKMQalFpYyV9NRnZr09DAi9X3UvhvPEVD0hCI=
X-Received: by 2002:a2e:a54e:0:b0:37a:17df:189 with SMTP id
 38308e7fff4ca-37a76582829mr5262931fa.20.1762520840175; Fri, 07 Nov 2025
 05:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106112454.124568-1-marco.crivellari@suse.com> <20251107130031.GBaQ3tb5GLPNeFSgbm@fat_crate.local>
In-Reply-To: <20251107130031.GBaQ3tb5GLPNeFSgbm@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 14:07:09 +0100
X-Gm-Features: AWmQ_bltorxWwCCREvg6uySo4sx4zlBCQV6K1t58IUnJ0ilG5MXf98YIru6j3WM
Message-ID: <CAAofZF6kFzxtNA+gaJa-YPySvekvYQ5pb-DyC=fG3EH5bAvHrA@mail.gmail.com>
Subject: Re: [PATCH v2] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 2:00=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>[...]
> Applied, thanks.

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

