Return-Path: <linux-edac+bounces-3153-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EAA3BE7C
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 13:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16393A8081
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA11E3DE4;
	Wed, 19 Feb 2025 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmIh9YFZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF501E25EB;
	Wed, 19 Feb 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969260; cv=none; b=gXouAPn086zRaeG7TYVWY7TsrSNmUNICe37i0kwt9dZqPhyH3VGYMIfhgMK7ihx3b/BW4c+HE2VvwMv/ETlnYZlx6IeS8bKxUcW09ZiSPp8k7sMu+3ksMPfCcG77sP2Vj5482UotPyTPjOD54SHzvK8RDRdLAhx8q1qutKFByBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969260; c=relaxed/simple;
	bh=Fjz2wRQ2ShbNjg5MsYqpGc5OQ5YhdoQPDeU+DQWLPm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ip/cdagw9IfbsIb/LwPWi8SRZApVG4z6vOlSmobLXdqSYyBf+6m2X/h70LaiixUJ/djOlGfZ5DemFFHYkX3OJW1U88AC63tphA2o7XO4iLGEI+IJB2die7sFk5frvkx7NW45BaQ/8lAAGl3O4vmoRXYlCB2EO39mZ/rJgu/QjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmIh9YFZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f441791e40so9782376a91.3;
        Wed, 19 Feb 2025 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969258; x=1740574058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKT6dQ/Hpais1hHLb61kVWIIOwm6mHm20lrPyIuJSPQ=;
        b=YmIh9YFZy9k5twZgVFQ8NjWhosk1aExF+ArVaXqhsF4OQRiokR4wFqBG0ifvyOuAgf
         yoCIjio1z886EvCfo/BdxIK2ORzDgV8rPO3Dp57jWP/ocK0S/Baghrb+aDkCu66ypRea
         pO85VbBO1gYDcGBmUzmo4lh+QjPUse6yuvOg2ZtOjN9HsJhHsKB+NZ3LfJRvFJTqyvSp
         /Ws3YV6UuHt/tP1y7Wf7d+8meQxMrlnuTZgiU4jh3tD1C9S0Db3wX9NzMRPKfiz829iA
         YVRVESdZkLab588ZP8oAkpK614fISkKkgE2BV2dvuJNi1KbFQpbCc0zEPRJlcHq9nigu
         8g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969258; x=1740574058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKT6dQ/Hpais1hHLb61kVWIIOwm6mHm20lrPyIuJSPQ=;
        b=WyFq20sYPr6cyiFO+7y+x51iwNenXajd0pReVhw/03Ck6y/s3lKprjVCcEOvBvsvEG
         k2z78X39bIoVbhYvdVQ67Yeu68mmuhLzFtq8cYnM+21NktLkosbCztvdZdPkU3QwmpKi
         v/zTUy6LUKeh7enmDMzPlaWIsx6JDKe00uqI+VLBHffZ2GcHZm4JsT6nJ5x9iDt+8j9F
         FtEcTdYjULIB5TTUU8lP4uEAhwAPjgYWIxrtTuz0Mk7lcIZb8FGJcMeUGou1lz7dh/rP
         2sKDcDthElIl5CpvonFnusPc/qlGLQ6GFrRfTURvUYBU99Mhmv7141yyzjKqvqmqqqcn
         Xntg==
X-Forwarded-Encrypted: i=1; AJvYcCWzDv2KutQC2im4DgqcME82NXFLpRReP/R6T5TRXA18rOPVee0umNVGNIl4Oo1Cu9rd64GncCMFl4qaV+dZ@vger.kernel.org, AJvYcCXVotUS5k5QLHAenUIBU/PBSB+79hFj0LZV4NYSPeRNEVHsX14QOBgzT94YpqPOcM05W0sy3GuWqIC/@vger.kernel.org
X-Gm-Message-State: AOJu0YyctvQKrJG/9Z3icKOqMnbSBHHtumlXK2xsYnS80UzSCXs7aPc4
	RPvJqfxKLGWoGdwaKmxsw5Pbgy/QR26olpq0gXTVfKp0zqkoUy+UprhJ/ivlVWXX8G1EvmbBhP7
	8WX7jmcTRluw4HduRjEzW4d6KE9M=
X-Gm-Gg: ASbGncsdlqBdLEkzGGtyByDvDRimYi7QIVmiO+9qf48Xx9fyx6TeiToorFAQH8oKNAM
	GlC9U4qWO9Pait0UvIdqBkEm1uN2HydxSHBk4t0sIyrCPeKZqB4bsZK1UQ8YhnUXeROZeBsj9
X-Google-Smtp-Source: AGHT+IEB3VIhecH+2W5XygkJ5CKwqAnlNqmnOpTnDBAs5kMZpruv0NCwJWAmr4uoXz7Do7TrnRPlkL8jrQHu7MALZHs=
X-Received: by 2002:a17:90a:f495:b0:2fc:a3b7:108e with SMTP id
 98e67ed59e1d1-2fca3b711cfmr9687477a91.4.1739969258066; Wed, 19 Feb 2025
 04:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPbMC766gbD52cADhXwK0BC-gN-pmTa0+4Kk4+hyM6LfAWrhJg@mail.gmail.com>
 <SJ1PR11MB608343DA951D303A36B2A29EFCE92@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608343DA951D303A36B2A29EFCE92@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Wed, 19 Feb 2025 20:47:26 +0800
X-Gm-Features: AWEUYZmKh7qtkfJXMCGpFM8Oe9Nsm8eVQDVbrjBxg_cfDS9FpSeSqnjNQ6J9lx4
Message-ID: <CAPbMC77KeX2y5Rq8wp60_RFLyPT_xOxY=HkBvWSVak7SXQZAiQ@mail.gmail.com>
Subject: Re: x86/mce: Potential Information Leak in __mce_read_apei Due to
 Uninitialized Bytes
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"chenyuan0y@gmail.com" <chenyuan0y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your help. After reviewing the related code again,
I think you're correct. All the bytes are properly handled in
the __erst_read function (located in drivers/acpi/apei/erst.c).

I appreciate your time and patience in working through this!

Best,
Haoyu Li

On Fri, Jan 31, 2025 at 1:14=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > I would like to bring to your attention a potential issue in the
> > "__mce_read_apei" function. Specifically, the struct mce m is
> > initialized via the "apei_read_mce" function before being copied to
> > user space. However, upon inspecting the call trace (apei_read_mce ->
> > erst_read_record -> erst_read), we found that not all fields of struct
> > mce are properly initialized.
>
> Thanks for the report.
>
> I'm not seeing it.(in upstream v6.13 kernel).
>
> __mce_read_apei() does declare "struct mce m" as local, so there is a con=
cern about leakage.
>
> Now apei_read_mce() does:
>
>         memcpy(m, &rcd.mce, sizeof(*m));
>
> so all bytes are overwritte. Digging down "rcd.mce" is also a stack local=
, so need to
> look into erst_read_record() for how it is filled.
>
> That happens with
>
>         erst_read(record_id, record, buflen):
>
> which will overwrite the whole of the "struct cper_mce_record rcd"
> declared by apei_read_mce().
>
> All of the error paths look to avoid the copy_to_user() in __mce_read_ape=
i()
>
>
> Did I miss something that you saw? Are you looking at an older version?
>
> -Tony
>

