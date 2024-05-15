Return-Path: <linux-edac+bounces-1056-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5988C5F7A
	for <lists+linux-edac@lfdr.de>; Wed, 15 May 2024 05:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766441F2295B
	for <lists+linux-edac@lfdr.de>; Wed, 15 May 2024 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED9381B8;
	Wed, 15 May 2024 03:46:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 845B037142;
	Wed, 15 May 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744763; cv=none; b=Qa+oIUM/62tEf/h2HVH2FW3AjxCa0BEzO1j7QtgW84iFaJnelx9iN9mJ8xxl3McjEhpwpxwGqluRQPEtIpxqusZRZkQD6KKPcZ/uj2LFsZlXN9C6jRmck8jIzoXYa3szd0CeGnMKJZ2stX1nKeO3M2IxFWgUOE8lyB7tcCnF5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744763; c=relaxed/simple;
	bh=bSk2pktMR0TCwUGzbqyIW1/sI5S2OHHcWRq8iKG2hfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type; b=HX9aO3fK5Czk3D/F7NDr/8khAegzScD6+Pd8TqFn6oVxTcZIF94FZZHoaioUkJbIsq6ZA2Bir50f+CS6b6AgeIJAL8OTcBB6bwvTHaPblfdKR4XlhVXHbC8OlVflC2Blki23G0eydmaeNAkhVtITBpaK4Mdyc7+yhOlwElPFhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id CB660602637E5;
	Wed, 15 May 2024 11:45:20 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: dengxiang <dengxiang@nfschina.com>
To: hdegoede@redhat.com
Cc: dengxiang@nfschina.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	prime.zeng@hisilicon.com,
	rafael@kernel.org,
	tony.luck@intel.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH] ACPI: video: Use vendor backlight on Lenovo X1 Carbon.
Date: Wed, 15 May 2024 11:45:01 +0800
Message-Id: <20240515034501.12772-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2db5beba-500b-458e-9fc3-f05bb982172c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans,

> A couple of remarks / questions:

> 1. Looking at the strings you match on this is not for a Lenovo X1 Carbon,
> but rather for a Lenovo Kaitan model ?  So it seems that the commit message
> and the comment for the quirk need some work.

ok, I will add DMI_PRODUCT_VERSION & DMI_BOARD_NAME to make a distinction between  X1 Carbon and other kaitian models.

> 2. I have never heard of a zx_backlight interface before and there certainly
> is no upstream driver providing this. I believe you need to explain what
> is going on in a bit more detail here and then we can see if this really is
> the best way to fix this. It seems that these Lenovo Kaitan laptops are
> using Zhaoxin Kaixian x86 processors with integrate graphics. I would expect
> the zx_backlight interface to be provided by the driver for the Zhaoxin Kaixian
> integrated graphics in this case. And if that is the case then the integrated
> graphics driver should use BACKLIGHT_RAW (aka native) for the backlight type
> and with that change this quirk should not be necessary .

Yes, zx_backlight interface has been provided by the driver for the Zhaoxin Kaixian integrated graphics. Also use backlight_device_register("zx_backlight",...).
Strangely enough, X1 Carbon laptops will generate two native acpi_video as belows:
 
lrwxrwxrwx 1 root root 0  5月 14 16:20 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/backlight/acpi_video0
lrwxrwxrwx 1 root root 0  5月 14 16:20 acpi_video1 -> ../../devices/pci0000:00/0000:00:01.0/backlight/acpi_video1

As you see, it will conflict with the same pci bus, then zx_blacklight interface can't be shown on the path /sys/class/backlight/.
That is to say, zhaoxin driver contain key code as belows:
#if DRM_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
    if(acpi_video_get_backlight_type() != acpi_backlight_vendor)
    {
        return ret;
    }
#endif

If i remove the key code, this laptops will generate two native acpi_video and zx_backlight on the sys backlight patch. Once add acpi_backlight=vendor parameter into kernel cmdline, 
just zx_backlight interface has been left on the sys path, which mean that both acpi_video0 and acpi_video1 interface can not be found.

> 3. Vendor specific backlight interfaces are normally only found on really
> old laptops. Since Windows XP laptops typically use the ACPI backlight
> interface and since Windows 8 they typically use the GPU's native
> backlight driver. So adding a quirk to use a vendor interface in 2024 is
> weird. Again can you explain in a lot more detail what is going on here,
> but I guess the backlight class device is provided by the driver for the
> integrated graphics and in that case the fix is to simply change the type
> of the backlight device registered by the igfx driver to BACKLIGHT_RAW.

As mentioned in 2  questions above zhaoxin drivers had used backlight_device_register("zx_backlight"...) as BACKLIGHT_RAW.

> 4. You posted the same patch twice ?

Sorry, i was wrong to think that before patch would be missed by you. also i forgot about the time zone difference. I am sorry for any inconvenience that I have brought to you.

Best Regards,
dengxiang

