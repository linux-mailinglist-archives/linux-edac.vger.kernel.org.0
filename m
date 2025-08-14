Return-Path: <linux-edac+bounces-4580-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20061B262D9
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 12:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83361887801
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BC318133;
	Thu, 14 Aug 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N5/SQq+s"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EF318139
	for <linux-edac@vger.kernel.org>; Thu, 14 Aug 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167369; cv=none; b=cnftkOwAzuhN4jH8Kvy3ymwb4tJEpDja5qsYIBmbGjlN6K2+eqcAT0X1SkCsD4YlwQLce8KZhOv5I2m9TTxzAn2gZtO9Ih3EzGTvFpr1q8A35mWEt2gBf1+lftX8QOBHK7mpC5fjUwh9UZ1HtvN3LNRYHZMY2x84H4hiaujoyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167369; c=relaxed/simple;
	bh=suQ8Z9B8F4VRo8cp/+TDeQzSOkEJ2qv8Lu29vePj1Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnssPwy8BmK+9dVzLVeXYx8L2C0BG1xDFQxf7tsTFRrhEfOh+OCvEm1McCjEXmHSsiVK2biiWWNX0wDRlg9xigS3ObgkA1zexvweQXywlz1gbplk4KWZK5ssGSmmscHfdLyWndfmmLZmVceZGSXQONE07dC/pLVNq9kGMEIyz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N5/SQq+s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CFAF640E0265;
	Thu, 14 Aug 2025 10:29:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3DwmUUunBiuD; Thu, 14 Aug 2025 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755167360; bh=MUZD4a8wHi+eBO4xxdvaD98URNvTnAP3Gtgwl30MJLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5/SQq+saLDtmZBsfhUNTx9LNjnnlb5pr6AKCHw8QwpuFc9M+UT7ID+YRr31wppgl
	 F4dv4T4UPpCWvSipraZz7mnltUIop1M6H1pkI+sqCZoQ0UniS7fzSjMTh2z5OM2Eyp
	 AqofHFWNxmAVCMpGmwBpSAoV/Y2jMicod0RGK+D+C2gLOZGuMr7u+SWHUhRm6WDpz2
	 RbnsyhQKxF0cCJkU798hy39yjDqgUKrWU6gdzsm4zdcJ0NJ6pf3/Rwops19EYz64Uw
	 W1f7yxJPftE3aJey1XYccqq1njM9+zwgsTixU4M1MVtofVMD7OIDPPTW07TW6vAOX/
	 9hbs4b6bSx4D7vsOca7g4G3c6ae395ZainQp6HLIsG7Vt170t4S0Dlhoi9MUIlNc2X
	 IjW9A2q+aTnP99kfAKxq8iFmTnfiPPmv5smEyDD1tWsxtqvoCOWJG3dIGp6p3ISfPx
	 zUvpnkoCjn+ckl+kdI5lFbnyvEgfudFBi//oQkV8Y/jyGCaI28MR+Hs8X+GyWLg2jT
	 UdRXLiMbdeDR3zbbiwJIeGLhW6Kn6XoeFAve6gDSG2wv26cUUKK53OCwqjP6qXM1Pr
	 KOpJv33YNRL5ybweD1o54QFtOdQNa6Atel4mMBt7gby/M96im5Xt+UNREncRDbt258
	 +WMK2WVNZkbS21rAZEsPAH9U=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EA5440E023B;
	Thu, 14 Aug 2025 10:29:15 +0000 (UTC)
Date: Thu, 14 Aug 2025 12:29:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Veggalam, Rama Devi" <rama.devi.veggalam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: Re: [PATCH 0/6] Add support for Versal Xilsem edac
Message-ID: <20250814102909.GBaJ26dZzvSs9usTKm@fat_crate.local>
References: <20250422171737.GAaAfPMbFtNKN6paJT@renoirsky.local>
 <MN2PR12MB42539E64E1CF2BFD2058DC50CE35A@MN2PR12MB4253.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR12MB42539E64E1CF2BFD2058DC50CE35A@MN2PR12MB4253.namprd12.prod.outlook.com>

On Thu, Aug 14, 2025 at 09:45:44AM +0000, Veggalam, Rama Devi wrote:
> [Rama]:  Versal EDAC is for Versal DDR memory controller.  XilSEM EDAC is
> for Configuration RAM in Programmable logic (PL) and NPI Registers scan.
> Both are functionally different. So, we have created separately.  .

EDAC drivers have support for multiple hw RAS components in a single driver.

The stuff you wanna drive is still part of Versal, right?

So what's the problem with adding it to versal_edac?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

