Return-Path: <linux-edac+bounces-5361-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4335C3A871
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 12:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778435020E4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6041830CD82;
	Thu,  6 Nov 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D9H4oseJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0530EF7E
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427823; cv=none; b=FtljeB0KGT4Bcqb5LIW2Nz4BZvfhV6Ct02EVXdeN70j5Au0bUQGWTbgQG4GFBWt14gQKjmZbwFStOc6qHeBFC5oNCiftTH7YprsMWlLudaLsApuV8zGi7VSgucoHBoIDdfhO2rURGB8M00v5LwM8vi3diBjcuIHsQSp56bI3T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427823; c=relaxed/simple;
	bh=5eNc+nOiefXMo/F9DPBs3t4XDeKRYV4z6yHiYx/WKvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TURF9BWHRCK0nq0xtVvQg9OgAwlB294p0NopFr3N3+b7iLZvV5rcRJ1V9DutNV3G0gK2qCW6QvCeNNoEvYHOXeFccINV5hNOID+1I7OaJ0Ayb1ik6QFnwrER+1M0xB1XGtxtW2z1OoIGk6tghKAn/sR7oTlSTEeel7zQj1TNgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D9H4oseJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a5d03b53dso8085811fa.3
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 03:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762427819; x=1763032619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNc+nOiefXMo/F9DPBs3t4XDeKRYV4z6yHiYx/WKvc=;
        b=D9H4oseJ3hO8TyjO4cRGxCR5xfDKVfmH4k+3XcnILdvZS9jZMvOr7m7p43qTdeORxG
         G/DXSl7tuyt7fUN8pueJzPdEJYHelNT1lrA9QiyrFMKDt5F8tDxmDFXkTbmQmCNEGfMv
         r0U5+DPAVBE2bjFhiDe2EZhKnZ8Oh/OEgFYPIVQXMyl4ax53IZpuOMxeW7F5lnDt8Pwu
         qCwi7niJGnKeQoxZglaG/AivUmgG1Vr42DNmdqkdvJJGULMoQuz9MTP3kbe1EUthaCkb
         lK7ABGY3peL0fOmUk/PxiYnE4QrP96LMLjWZYOJINWOpCqSWtU/KPqpcKbP7/tfFufXC
         Ytdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427819; x=1763032619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNc+nOiefXMo/F9DPBs3t4XDeKRYV4z6yHiYx/WKvc=;
        b=pnW9PgIN2z+0b7Mpa8lR7I+kAO7NWE5QSTKoj+WMCmxMpXHxqICTU09fhZeYfbKEdT
         5S3G+vTdlcua0s8l5nnC639izqTfCM6YZ3kXso9fIRxBSPl/yRkpkf73wDqYPwG8qQw3
         Ir4N0hdQErGpNn0NGtIBWXhd5CAXsCkPjqXSGJKMYSYh2eGuX01BUwgmJSwA+XKKcMrb
         6YNuMTguG66Y0gQUGDJ/rloxsPBP0qT/i95Osc/q8SdVB/OMdMBjyjk7kGxKW2qZp7De
         7fkznaA9+IV9/c9OmysfDlp5xQgd51jkmh1Kh3kyml2zlMFRcKkLKadA83uo5QlIFTPB
         Dk1g==
X-Forwarded-Encrypted: i=1; AJvYcCUAjYdgqdL5Em+0rKYE1wsRuXGdK6SAT57iUUSfspqnIVdSIBWyIEV7NEFDQK9xW9O/33bHbQxmTeYT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rIYIGifnaNmmn1fbbRMKCIZynXnpVkz6jQvpjUX+Y+yF41pq
	l7cDBPxc0UhkkQzB2KN2j0SvfEPt+ngEBAScga1uOLDH5FNnwlNtetFY54BkWWfqQzsg0lRczGT
	m/BEGcILmDYkadWL3x/Sb+r3AoIdOCG0rTRdyeshnhvJQwpiggBbb
X-Gm-Gg: ASbGnct9jfknk2AKwVBzEnusDOrFzh0TmmmoMj+dRdzAno8sKZFHFRN/T5LvGWU5xfz
	TmU3HKJiUPhpdZ3Igz1YB2pzpkPH33yATHLziIjwNKdNaxCoW4CMA2VXRQwzK0Cd/5Gr+cLHVtD
	CiXdxotajWZ0ON1w000S4YE0S4IoG2Z6BqE6KO42coBEssPdV2L7VSoDocLYkhpRKc22lAw0jUD
	mhGpKKvUrBLbupItwhHw5LcDng5w9OzRScGfPPzwrRvSEyFLYxZOUOoj0s7vnK0dlOKwcGrIRyD
	JE/Y4XnMqCr/SxQ+cw==
X-Google-Smtp-Source: AGHT+IHYcENGTqvymfQ1WOetN6c+qYHeKLd/0G4rh8vRBzb09b0W5AZ86qMpZX0M21EDepNZjbeEnDbHONIX+WPYXYs=
X-Received: by 2002:a05:651c:23c4:10b0:37a:3260:c8ad with SMTP id
 38308e7fff4ca-37a513e7181mr18653281fa.16.1762427819514; Thu, 06 Nov 2025
 03:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local> <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local> <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
 <20251106104921.GAaQx9MWLfhyqHNDYK@fat_crate.local> <CAAofZF7cz_F9qgr7WqbORwH5iMuAO9f0SkWRQxQ4ns4o2X_xJA@mail.gmail.com>
 <20251106111137.GBaQyCaXz4RBMNsULJ@fat_crate.local>
In-Reply-To: <20251106111137.GBaQyCaXz4RBMNsULJ@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 12:16:48 +0100
X-Gm-Features: AWmQ_bkuBOPmW7AIbnSHHhM4OteYDnQbRCEjZ1_1w6q1h8RBmH44fIN9Z7Gcf0M
Message-ID: <CAAofZF7j-Y6mSydny2KtpVX1n5GTKNhu2PE1R7dwB9=SoAzPpA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:12=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Nov 06, 2025 at 12:03:51PM +0100, Marco Crivellari wrote:
> > I was torn between "replace" and "rename", because there is a new workq=
ueue,
> > not only a rename of the old one, because for now it is still existing.=
 :-)
>
> You can also say:
>
> "Switch to using system_percpu_wq because system_wq is going away as part=
 of
> a workqueue restructuring."
>
> Now it is perfectly clear what's going on.

Cool, I like this version.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

