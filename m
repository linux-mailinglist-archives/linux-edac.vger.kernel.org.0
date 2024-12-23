Return-Path: <linux-edac+bounces-2748-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EE9FACE7
	for <lists+linux-edac@lfdr.de>; Mon, 23 Dec 2024 10:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311CE1884FAD
	for <lists+linux-edac@lfdr.de>; Mon, 23 Dec 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931F6191F84;
	Mon, 23 Dec 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7+gkaYQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126C171CD;
	Mon, 23 Dec 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947933; cv=none; b=HGyjoImsYEqWjcbbvgpYONsGf+lGDjEGdYky0mbwXjE+X+4vAkVJy/IRAGmhBbmmuCNdzBf34dPJ8fPkxhbYVqbYl2d/grlvazm8ox4KVJpaZsp7jMXQDT90nwKKt1axC2m55YE1Kk0idK7hnCrvcsERWkHklw1xaS3jW7m2NAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947933; c=relaxed/simple;
	bh=+x0FEzSNO1d0kLYobs0WlrrHCQs0vSKwxETXH3aaguM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx/vp0GbxK8qDe6J4bGzCoIiHoMP2oghyS61mDFd8Gr5qhdk8YyrHhbNWFKytlqbK59TBbVQSMEIuvtPa2G6LXt7W5+P79SNfmAPKiAyCFsKgWtq/3FPYiAE+COwt2HABHB2pOu0ZglevqI2sCeT8fu5OU7CaBsFbqkVGLQxXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7+gkaYQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so6772762a12.2;
        Mon, 23 Dec 2024 01:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734947930; x=1735552730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwoqvZPFzYtMURALwW3zd0xfnrke8MHwXbCgCRzcWLg=;
        b=k7+gkaYQkITHM7CjBg9NAA12u83Y1skdoAGyG2Xez7mtU9c6N4OlbICIz+kAsmTvvD
         kMtIcoqO8RbVMjNoGXMANbrzWchhat3C5x7hug90Khcw/vOxJt3dmMkQiPX+uXkTMso9
         SqJ/6rybzrb6N05u4zvKOjwKvs+z6dwKaJE3naT7TOHIOwl0jiE1se9qjTe7ZhwWBjVO
         peOBElWLWUejOVhWuCxseRazwWYTYFLuJV+JydyII3QLL6MYkBcVS93sGAeGCVVyu/Ng
         56aDu4cRRpsv9PlEMlo6tnkClNmblcqAkJhMaiU8Dw08WzdKW8z7T8TtsOhttR0+5Snf
         CVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947930; x=1735552730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwoqvZPFzYtMURALwW3zd0xfnrke8MHwXbCgCRzcWLg=;
        b=rtvSt5W+V/k66MYh6uYbDgH3W+iELN2Xv7KPiG30TsGldqDLHz18/Q6BIADbtccWh9
         9v1/gydBO6abg7qSn2llGhhjU2ZmRDTc1M8AMM3CL3XF4lVaoGBHFHNU29b8+T6/hFFB
         J3woYEDjmRo+Cu7QhDmcYqbhWplVg4MurhpXxrsvt6kqV89Xz1Fx/i8exFoMfXHz7m0Q
         qPEJB9RtfbsBZKoadKAKAXiJ1h9eu6Qqube4+DvLFrK/hIldY/6vWQTdzZBCam3LZ0Ix
         kP6x927822Mp5ekj7ZKAE2Gtx7e5RYrzudwNlNICZaoyqt+RpIUrG2TtTfqqz/aBLAxZ
         +0nA==
X-Forwarded-Encrypted: i=1; AJvYcCU0CIY+3h5yEM4fibGkFYtvDJFP5OW9pZfaEU7Ag4sV04iXVpk+ZTCtGaZtXn7wlGG/YZ2OT1VTw66taV68@vger.kernel.org, AJvYcCWheColUugUfGwjkn83lTvmOM79FU0+ln70H9imG1400R1v58gONj8U/TzdNcT14XJ2VWlSJVR/rx2A@vger.kernel.org, AJvYcCXNib1XGRmCsV1JGYrgvQpNNL6+SPW6fvJWRnxr45aWbk/4RrvFlMfGDh25ImgBb6l12u+I2gSYI9QNAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyD21d9uC+hqvvuwRi3brHkXjTFXzfVgG9WcSA62UfhGiUz27
	coMtidnmLICPIO94JHOlx0qmXN1KQWirNHfTRmoMp8xrE/M9/DisNMcnjb2RmpQCj+r1WVtWMi/
	nrEqxoJVdI64x0z3gxFTP4wxv4xI=
X-Gm-Gg: ASbGncv2K6HWvojAYHBovMya0dQjZWpS6s4mb2n2ZpIcdjQ+/j9xbOTCcGEBeG6L3nm
	bLA/wX984L1iEAWeXd/RsNkyWUKIt04hrmCL1zg==
X-Google-Smtp-Source: AGHT+IEDMOBjhGFYBC/0mhYJXKtS2Sa6zscQWy83oW4N1m00J89fLgTVxqSMvi7VeayWSq0CnHk19PO8yezpj5Tt+UM=
X-Received: by 2002:a17:907:2dab:b0:aa6:aa8e:c89c with SMTP id
 a640c23a62f3a-aac335626acmr982693166b.39.1734947929710; Mon, 23 Dec 2024
 01:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
 <20241122100625.24571-2-shubhrajyoti.datta@amd.com> <uw5yvotdr4u5uau7bqjj2qdmkf5ay2bm7km3zhqunbixzljlw6@wi6cujvdhesk>
In-Reply-To: <uw5yvotdr4u5uau7bqjj2qdmkf5ay2bm7km3zhqunbixzljlw6@wi6cujvdhesk>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 23 Dec 2024 15:28:37 +0530
Message-ID: <CAKfKVtEREOLxK=SF5F-3MkpxyS+HcSTOH-pML2b4x2pCV13XMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, git@amd.com, 
	krzk@kernel.or, robh@kernel.org, conor+dt@kernel.org, bp@alien8.de, 
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sat, Nov 23, 2024 at 10:14=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Fri, Nov 22, 2024 at 03:36:23PM +0530, Shubhrajyoti Datta wrote:
> > Add device tree bindings for AMD Versal NET EDAC for DDR controller.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> > ---
> >
>
..
> > +
> > +  amd,dwidth:
> > +    description:
> > +      DDR memory controller device width.
>
> Use existing properties.
I am not finding any existing properties could you help me with some pointe=
rs.

>
>
> > +    enum: [16, 32]
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  amd,num-chans:
> > +    description:
> > +      Number of channels.
>
> Use existing properties, e.g. some of the DDR schemas describing memory.
> Look how other bindings describe actual chips.

could you share any example. My search didnt return anything
>
> > +    enum: [1, 2]
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  amd,num-rank:
> > +    description:
> > +      Number of rank.
> > +    enum: [1, 2, 4]
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +required:
> > +  - compatible
>
> Eh, no resources? How do you talk with the hardware? This looks way too
> Linuxy...

will add a remote proc property

 amd,rproc:
    $ref: /schemas/types.yaml#/definitions/phandle
    description:
      phandle to the remoteproc_r5 rproc node using which APU interacts
      with remote processor.

  memory-controller {
...
       amd,rproc =3D <&remoteproc_r5>;
     };
>
> Best regards,
> Krzysztof
>
>

