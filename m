Return-Path: <linux-edac+bounces-1633-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB794C7FC
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 03:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378B928191F
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 01:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B252748F;
	Fri,  9 Aug 2024 01:22:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873F748D
	for <linux-edac@vger.kernel.org>; Fri,  9 Aug 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166556; cv=none; b=ab02BgRFX+iOs0OUVn94yiB99JBU2GRlZ0S5JBHu32lI57FVP8mitVOpRSX1rOwDoNK6shbYnIrcds0v0SY85D/2YE7JFFxdrXs2Lflzyawo92AZIcUAu4dU+o8qmVlP3hBv33GuByCmvhzzi4QVgfm9QX60aMXLXuFJrYs37sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166556; c=relaxed/simple;
	bh=PLTsVzq6zD3/ZQlwxE6qNvdwHEaG378O7O9EWGFyxS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOgIlWTUDf09GfA2W6hkRA4dQ6sGzFDMSQVFY8U/SmaOJ9wbDCVJzaEsa21GWgWPKIXEt0KCXqrfgyzuCTrdNKEy70jP7Urg4uo9fh75+g530w0h8qQOizXv7Vv5gf4sww9BZTKweBAVL/s2bKP29fhqZs7CasiIuki4rIDqmDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f01993090so2104310e87.2
        for <linux-edac@vger.kernel.org>; Thu, 08 Aug 2024 18:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723166553; x=1723771353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5p42Ud41p4pKPtUVbUEEPfzG14CRoilBz1OMm1cvcc=;
        b=Q4yT/S12grtKuo+PFzZjUCRmuQDbcJkNT7vxG6YxJRXTqHai5u36mvYs4krkvGIMc6
         FMsjzXygqwC6zlhoWya1p0ukwVcG1cKA10TXCO1yMGMoNeKi6B40dzQ/FVPVltyoEFqi
         ICIxmZ99uTZKSrEL17w6GGenyEwfc8EtKeblvOeVwgkzUVbkhqhLajQUNMjWFF7Fw8jl
         Yk6ywrJTKm4m2r1h5bwraGbEdDQ4d/S4i555kNnqTsWUcOUib5nA4PcTS6UXzahjYz33
         LnrwXQO2k8iX8ni6wr64fPtmhdTb8dE/yR04qaS9cS+y0Rqd1HrRmKbO7vmseJd3tPml
         bfaA==
X-Gm-Message-State: AOJu0YxllW3FVifYeGUssBYzSevcBQ3X2AC8mBdI5hJuTas9AA7heXD4
	mqZHD9KIHdLpDXnrViGEhsLK0fMSNwURbo20F2mg6tS0lh59sqX+w7FrmOo+EldCjg==
X-Google-Smtp-Source: AGHT+IEAUXszbyfmZsb0kaF3VvMk1EtIJnCi+mpPqFuS/iCeNMJTr6+OuzaWhlAojB8yBtJXTIOYAg==
X-Received: by 2002:a05:6512:6ce:b0:52c:e3ad:3fbf with SMTP id 2adb3069b0e04-530eea20e74mr3007e87.42.1723166552410;
        Thu, 08 Aug 2024 18:22:32 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de4656e5sm809272e87.189.2024.08.08.18.22.31
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 18:22:31 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f035ae1083so16325311fa.3
        for <linux-edac@vger.kernel.org>; Thu, 08 Aug 2024 18:22:31 -0700 (PDT)
X-Received: by 2002:a2e:9917:0:b0:2ef:24dd:8d86 with SMTP id
 38308e7fff4ca-2f1a6d0a79dmr700401fa.49.1723166551521; Thu, 08 Aug 2024
 18:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <202408052135.342F9455@keescook> <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com> <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local>
In-Reply-To: <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Fri, 9 Aug 2024 03:22:19 +0200
X-Gmail-Original-Message-ID: <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>
Message-ID: <CAOq732JV+zcCqgqTbAtVdE+7jYuen2ioG+F+3i5yaBd7Aj8ANA@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Eric Biederman <ebiederm@xmission.com>, "x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 16:55, Borislav Petkov <bp@alien8.de> wrote:
> I'm not sure it matters either. You're adding all that code and
> task_struct member just because the kernel sends SIGBUS on a memory
> failure. Oh well.
>
> How is that more beneficial for the overall recovery strategy than
> killing the current task? IOW, what is the real, practical advantage of
> this and why do we want to support it indefinitely?

I don't have a "real world" use case, we hit these two bugs in HW
testing.  Qemu relies on the SIGBUS logic but the execve and rseq
cases cannot be recovered from, the main benefit of sending the
correct signal is perhaps information to the user.

If this cannot be fixed then optimally it should be documented.

As for "all that code", the memory failure handling code is of certain
size and this is a comparatively tiny fix for a tiny issue.

Best regards

