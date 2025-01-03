Return-Path: <linux-edac+bounces-2773-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE4A00421
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 07:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DE73A2D6E
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 06:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E13117ADE8;
	Fri,  3 Jan 2025 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Jqo6D1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771084A5B;
	Fri,  3 Jan 2025 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884830; cv=none; b=MUFBH85Hd/e1Mjwogzr7m+Y3BieWGykEt4qtJlJ39YQ3Bu78gbWtM0ybxPezLrm/oJGFOTQEHkSqZx/e9VQmZof3POyQdktRgWX9uhL0Tg/uWe9PScteF9iUBw58jXl+Y5fwAtWB3LrGgTt9BhcvSVzz1BIQVpQr4z5NT9r30WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884830; c=relaxed/simple;
	bh=SLl2mnq6N14xFhbVzzZj72tyk9n9URx2x/PSyxHQR/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bExVlO4BDt62GjQUwH8ECIaRNKdhkC5wzBEXetlLHq+xBN6ZpaeFoc+1/hQP42Lux/wZvVBKw02h97wQBA8HCY9g5YYgXfqspZOlO4eZc7ytFh2+FHc0qa0/3jFjepZ877JADqyUflpMmefZAjyaZooIx/BnopjjHyEDC2n/2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6Jqo6D1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so20326968a12.1;
        Thu, 02 Jan 2025 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735884827; x=1736489627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u8oZEswI81GcCDh0LcR4az2c6T1UFbrIkFyXiVsqC4=;
        b=D6Jqo6D1sW4ns63yzmYlu6J0SYkD+tqFz10abaLSSN1lstp9K4AGX2BZg/ysXH0eBq
         UM2bVvcLSUErnHPPYZbDup0/RS9ymjKi7i5R6BVZM3f+jVRQxaXL4RhM12jO4de8mz7K
         PhyqAQ2kRNWlD3WiPBfDxxbSjdCw400tc9qaNjfSeq4jf/4LOvLMDW/K9YQ9yq+d3nK3
         Exsh4SYltjgf81gcM/f0BjJsv+381L7rF3mFIZ9FgrlNxyRjAmeMszrMobJtkB3JrLJm
         I6B1vvFD4x6OxadMMfsjsvcVZY0fzBimgw7n4+MoUef9M6n5mKEjvWmPdoES29/OTrT1
         FObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735884827; x=1736489627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u8oZEswI81GcCDh0LcR4az2c6T1UFbrIkFyXiVsqC4=;
        b=M8PO0Yc0fkQLqN+oN+/WFdRQ5yCsSx1l+QRAY8e4v6x8+wwrjLs7oOwwDpL7D2R7ez
         42j3evqRDRTVC+eB9P1L3a7VywbQgmHndK7IAGMnCuuLL/BF8dvPIwyv7M+2bX01z1NF
         MpBjmCnjTJFDrHvaheEwTT13AfHK6tQpkuGjJ0zkViP5SA17R1GfVMYeTcFMmHox9gkM
         eylbQCaZlp4OLDohj0BuvbWFg8PyHcSU9VrjY6XNbAkbSTUqr0VSto1u++Ue5yGXh/4w
         zymfFCjfVfXAHZbAcDOKYRyCKbavDWmS4V0SNbyFBij+Lh7YP0ijOZdD22RjUAJxzfLH
         C9Og==
X-Forwarded-Encrypted: i=1; AJvYcCV+wXPjhXla1R155C+8k56+BaPb4j4vmHskncF+XEa1MRpE6+OT3dqZQD2D66prJTnlAZiwqOLpjPOR/Q==@vger.kernel.org, AJvYcCVbPxdYpQVrLsaDYVOIVxYy1zO19RbRjbmvXkzPlmgcUmUhwde41fdZN9aMx8E4AugO6w3qPck9SY2a7xqT@vger.kernel.org, AJvYcCWg8Wr4jIsG+biKiU7MfHT5khcu1DvqZQ7HrnSgEdWYuMzASI4RJDYqtOGo61/pjyxLeR6nhgz/76Uq@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIlKElfJ6DymIhK1K9+gMXCDwi6ypdchBYfHkzcVmn/1A1EI0
	X9PJZbkbRnXJ0C36I0WTm3I9d6LCC29P0frbED/UuNo2BOvzT49Z5qVN8QS5OJWWFIZ43LogT7C
	y9+QxWX3TlEeTAuwi8VHe7XaUiOE=
X-Gm-Gg: ASbGncuv3nRMszCLekozCHdkAnDD/2/yjyBW3aqHRxLaiElmEUL/qlEDNML6XG/aeOA
	39YSSJwpRdYTMUqbVFx/tO/2LYlpjaMgs/kFx3A==
X-Google-Smtp-Source: AGHT+IGM4CmnuVybu3TQVoL4EX24ZT8Lf2rMNW4EKXcsvKn/Tmw6L/zoQjGQ2C0jhMSKha3lpw59cqtrWzt52YwsSeA=
X-Received: by 2002:a05:6402:240f:b0:5d0:e826:f0da with SMTP id
 4fb4d7f45d1cf-5d81dde858amr43801156a12.16.1735884826944; Thu, 02 Jan 2025
 22:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
 <20250102174434.17677-5-shubhrajyoti.datta@amd.com> <adca2723-611e-4b7a-9921-84af6596745d@kernel.org>
In-Reply-To: <adca2723-611e-4b7a-9921-84af6596745d@kernel.org>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 3 Jan 2025 11:43:35 +0530
Message-ID: <CAKfKVtFNRPa64vpJ0t-ttJrp-Wc8+F2jz+Qy02BP8sgZZixsjg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:31=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 02/01/2025 18:44, Shubhrajyoti Datta wrote:
> > +
> > +maintainers:
> > +  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> > +
> > +description:
> > +  The integrated DDR Memory Controllers (DDRMCs) support both DDR5 and=
 LPDDR5
> > +  compact and extended  memory interfaces. Versal NET DDR memory contr=
oller has an optional ECC support
>
> Please wrap code according to coding style (checkpatch is not a coding
> style description, but only a tool).
Will fix .

>
>
> > +  which correct single bit ECC errors and detect double bit ECC errors=
.
> > +  It also has support for reporting other errors like MMCM (Mixed-Mode=
 Clock
> > +  Manager) errors and General software errors.
> > +
> > +properties:
> > +  compatible:
> > +    const: amd,versal-net-ddrmc5-1.0
>
> 1.0 looks redundant. Usually SoC does not change... Anyway, commit msg
> should explain why 1.0 is needed (IOW, why exception is justified).
>
> > +
I will  change it to
 const: amd,versal-net-ddrmc5 instead.

