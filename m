Return-Path: <linux-edac+bounces-1733-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D5495E303
	for <lists+linux-edac@lfdr.de>; Sun, 25 Aug 2024 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C064D1F21814
	for <lists+linux-edac@lfdr.de>; Sun, 25 Aug 2024 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3697E74076;
	Sun, 25 Aug 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXEuB+ZM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVwO0QZc"
X-Original-To: linux-edac@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A3801;
	Sun, 25 Aug 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724584601; cv=none; b=siqiV8pvAgs2ODIS2zpAq8KLG82uXmeMVXOlKj+Ymnp2tq8sDWNG1eyX+TTUlvu0JDUKQ0t2clfgMXH6zCzVSEmZbzJr9C149iiYVjUpIuC07Ut06OaIlKFKK3IgOeiNrdoWvvecK92Rv/wMumjCjWBucQerzSe1X/mG7OoMzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724584601; c=relaxed/simple;
	bh=RajbgqR5Erm4zWRhKcrx7qF6pT7BQY3NbOH8twt7mK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=So2Yx8OK0x/QrJloUzIzl93d1kNbmCoppXisxELmqJBHKi5WsNVZl925kp4rkCeAa3cIkeT1Gg4dBJHwL8nIEPBMgRMW/CRC9m7WeMMR8XEOXPPuItHkfL+K4Y1mTC8cDS2taDFYiaNeiFP5n4WXw3IQTSXmyAGln2MwHHrC/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXEuB+ZM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eVwO0QZc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724584598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ejO4Q+Mjm+7UqRKEKTS3n25cv2Z3Fr9xoOnbp5A5p6U=;
	b=GXEuB+ZM/wAEYoOyxBhNuGWfhBCPJQ0AFMYijKs+y5t6+GjerNj0U1S82j8eM81g8tOj8W
	fd/PhPlo18iJbtQGjDyz2AoodoCdNDZqSt1NR2PJfNJylUkdgHLV48QSgYAa1Jp2mnUElF
	WBZ5JUz7JX2j+Rtqt6zs4cYDJgCV0hnWedkhRxeplc7rzgFrvxpQWs22agsNAqFDW5duai
	EtQmHMyiAvGWKkAcSibCshEqTV5t9573mIjZeLGHqRMWiFoZ443ctVtWmz1cyCdtF/sfr1
	GK8bFFDrcA0KcLfIUmRswg3ZY3wlcsK3t78bSVn3Zd/Gsn1zlcRoBHsFJqTMWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724584598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ejO4Q+Mjm+7UqRKEKTS3n25cv2Z3Fr9xoOnbp5A5p6U=;
	b=eVwO0QZcWsLPzD7ImqOfkJjHxEyPo/CFW0UIYupcjP0Qh07tJEbKoQDy9p3AsnLtJ2UMRk
	ms53hj19WxemwXBw==
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, boris.ostrovsky@oracle.com,
 Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with
 non-core banks
In-Reply-To: <20240821140017.330105-1-yazen.ghannam@amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
Date: Sun, 25 Aug 2024 13:16:37 +0200
Message-ID: <87jzg4g8dm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 21 2024 at 09:00, Yazen Ghannam wrote:
> Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-core
> banks. Each of these banks represents unique and separate hardware
> located within the system. Each bank is managed by a single logical CPU;
> they are not shared. Furthermore, the "CPU to MCA bank" assignment
> cannot be modified at run time.
>
> The MCE subsystem supports run time CPU hotplug. Many vendors have
> non-core MCA banks, so MCA settings are not cleared when a CPU is
> offlined for these vendors.
>
> Even though the non-core MCA banks remain enabled, MCA errors will not
> be handled (reported, cleared, etc.) on SMCA systems when the managing
> CPU is offline.
>
> Check if a CPU manages non-core MCA banks and, if so, prevent it from
> being taken offline.

Which in turn breaks hibernation and kexec...

Thanks,

        tglx



