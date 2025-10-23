Return-Path: <linux-edac+bounces-5169-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E176C02A8E
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441591884CF8
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C11342C81;
	Thu, 23 Oct 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kScwt8Sb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A9340A6C
	for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239214; cv=none; b=eRryXwN32YHAjOWYwdkA7t/ZED4G4ci8JqI1qBMHyxcLcZy6R3BN8iyM8AGQ1+gsL6UcqxE7ThbXgiGm+5FRqrupWSwIeNav9zgYfbxHm5k8xj/gnAtu8Et5KXxegoLBYLcP2CMecgDcMEZmq0K+v2yDOmB51O9YSeRh32qiSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239214; c=relaxed/simple;
	bh=PECSIW3krhGuJb11E3crJdvrNsJtWevjN0kDoXCOJas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIstXRwczrbbZX+PB9tIw6OBXLBIgghIMFJi2gq0dCqDeGXZzfV4Y6HRvDaHqAXRFvKE3s45ln9afZAy2tbpX1JrIfYrtjXJD5ZRmUcyY/DGvpCpogDHZVK7mGdSuJuN+L+LIxESToBfEwCqQBvzfZOhQjYTN4ctsfwf5E+Twl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kScwt8Sb; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-375eff817a3so12531621fa.1
        for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761239211; x=1761844011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay+42qhIEPdXa+n4WvORTn6I3PLfhdqjaHkfndYAfck=;
        b=kScwt8SbKBHth+fbMFKTAwrZmBaPQi32DE8oVyRXdmtndtBygPbSVKIVG4BGdWpzom
         C0jlAMxfYNiBr283VsYgFqPWUzfp/0pE8goq33CLTHWLWMFbvsMTxjmVI7LdxupjM6XB
         dbBDWm16aDJj9S92TftoFATwLNSANvJjcx/WjFoHu1zo9FObY63vd6+PVeWiltKa6WK8
         z+ZFHd83aSE3UGycQwhBGl9VGYI/GHW0pQh07Na7rV9FwlbqdwWaGwc8wFFtegMC4Cle
         rIkiiDtxqWfecqv4luWCfFKJGCWajd6qtA4NdfFl331fjQtsXTGlsN8FnslemrBk/Mmm
         A0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239211; x=1761844011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay+42qhIEPdXa+n4WvORTn6I3PLfhdqjaHkfndYAfck=;
        b=mCLs9FHCEgUpzJssg2DkHHJyoSEs/bQj8fQuhGxQigeZwv2DJvRTNf+raQrUlgCl2L
         846675tCFcnbkiFmNDmfWLprDs5l09hGnYqKZjTazCk5s4e1EERfqEbG9BjDE+QDlJUA
         Zjxd2RcEWb7cAmsooY7tKWbxN5LfcWlRYdPe/YTNhoRueib0s9/snGDriMpDoj3wL72N
         HctbNvUhf18geO9OhQ31KVtNBacpYLgMJg3KLGKZolDU2Qw1PKF7Vkg+EDFKtyt1ClH1
         gP8Au/DLXn2rN7DTUMKu3274ji1lRIV9csfFKhUkwancxaOeIyQVGVNNPH9XaMEcjhtW
         Ht+g==
X-Forwarded-Encrypted: i=1; AJvYcCUBCs1Ek8PCUyBoVwX7oYLpGnXYRZNjDdkBYSvfFfVSqSLMtToDc7FCSiGTWJvmaQArUykI8gG0FTVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfyp/RMfSW2gMkqsBWQqBr1rqAYdnivpGtMXWQ1eQ1Ysy2Xa8e
	ETDlKKPIYX1SqClkK8AcYJQ///tyiZuSLjcbK9iDr8LQohi+KT/RSuJk
X-Gm-Gg: ASbGnctAJuK9VEq5BR1Haj6xPhgCpBE9fdo2WLKwaco4bsLG+NVUHxniKp8LH8O+war
	uOK34OB+KTOujGMKL2s1K0zfFRgnKSQY6A0WQ/5VCFZr/DRuA5WHb7CmaCUz+jVIZ9x+y1w6HQc
	BO1OyWxwF7m9PJQ/ad/o5PCbrESO0lSzRYzs7Iiz8KiT6AU7X0T97HwDaJxn/imPL0YEDmDL6Tg
	0NRyyTOPZ7YPDgqDAcREidnHPZwyu/alphqfodRNV5BsHa9QWm0k2p1757Kr0IbRsqiamNyyKrB
	pIIr1/wsDxTaW92rQkhn5iUy4ZfVzd4J0zXnyuLOP0pgyO+IjS6NWhDVHZ+BcB5dcNUrKw4qqyf
	eHA1mEHh9u/5I1RmzuQcqLrb96drT+OAxvnoNXhLk29Hbj+cyPRBT2vZNgK5q1aHVSW7XrYH+P3
	J/LHoloGUIefZZlww07egqaMmudI8=
X-Google-Smtp-Source: AGHT+IFCU+4vgavCbFNLb+Mo4lZ6B2eZuRjKspgl3MEMe+pg4okffP3jDGlOShhYfpkKT3xoeWgSbw==
X-Received: by 2002:a05:651c:199e:b0:36c:ebb0:821c with SMTP id 38308e7fff4ca-37797831bfbmr72598861fa.7.1761239210349;
        Thu, 23 Oct 2025 10:06:50 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67dc50csm5770731fa.41.2025.10.23.10.06.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Oct 2025 10:06:50 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:06:44 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Shyam-sundar.S-k@amd.com,
 bhelgaas@google.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jdelvare@suse.com, linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, naveenkrishna.chatradhi@amd.com,
 platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
 tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023190644.114bf9f8.michal.pecio@gmail.com>
In-Reply-To: <5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
	<20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
	<5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 11:22:29 -0500, Mario Limonciello wrote:
> As this is an ancient BIOS this reminds me of some related commits:
> 
> aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> a74fabfbd1b70 ("x86/ACPI/boot: Use FADT version to check support for 
> online capable")
> 
> Does reverting that second one help?

Not sure if it's worth trying? My BIOS predates the ACPI 6.3 spec by
several years and (if I understand correctly) MADT revision is 1.

It seems Yazen guessed right: they list 6 APICs and mark absent ones
as not enabled. But I don't think we can assume any ACPI 6.3 flags to
be valid here.

I wonder if some quick check could recognize those consumer CPUs and
simply ignore hotplug there? AFAIK it was never a thing on AM3.

Michal

