Return-Path: <linux-edac+bounces-4110-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F218AD5C96
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB50F188363A
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657B1EDA02;
	Wed, 11 Jun 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="irpbFja7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6F198851;
	Wed, 11 Jun 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660375; cv=none; b=WZPEjMjFxeEufEYWcxMH0BMLv5DdV8YzeWzcMaf5L1Pt4u79vbZPyQYQIX6c+GZda96dvsn5+WE0Ba9UImTBK6RkjUVH5erQCWt85I0z078SxDvyLuz5mlwdamk70ZyMzQZB1QgMc5+ZWqoQx4TwCt1xk0GDdwHz7T6m0A4qc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660375; c=relaxed/simple;
	bh=pKsYBtZSzJFBNl3Ug9YmBQ3IUiKtUuYSnIdF26bHabc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXwzmHr9R3UdReRLFFVfbHbhkqG5ICImTf/rv4snF2ddOO29qoPXYG8BPu8GRS9lW6+SZWbhlz60zgBd0MlKksCieA3Rm/1Kde9stkLe4TN/g+MAapyLCocOWxLv/i0Q0aC6K7cPT1LFeovY4pVUTQkQf3V4sG8BkGBAcXQ12es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=irpbFja7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CBBC140E0184;
	Wed, 11 Jun 2025 16:40:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HV_N0c_jC9Zt; Wed, 11 Jun 2025 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1749660018; bh=pKsYBtZSzJFBNl3Ug9YmBQ3IUiKtUuYSnIdF26bHabc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irpbFja7+nN5gvyS2dBJNnfdQwL4IoXZgjiKGGLCkJcpE9TxYIL5z0b7+08iJ7eyj
	 U/RY7VNhGdx5pEbgv83Wezoniq6njA4/lg0ZSoOHGDjSc7MdQrhO3WeyfKZ95X5ccn
	 ay2GHcf1IybVIuITZX35HLf8vBgYP9x5QkM9B/qTc7P9w9lq5d+UdzSDDsaRd6qkWR
	 Dmsl/UeBkNbK7TEO1moiiINyst5slk/xHu795Qimo36MVG9yhyJ1heQ74GKT5zv05a
	 Bl7GlviUC46ps3U+hTIJY+MUExTzg/3W1w3OGeSaqUc4ydckQNyfBgEE9DfXGLSSYM
	 LNRks5cZ8S0mO8zFqGvWvTB7X/tfcX1/qDPCgidj1tauZ9IYYsfyYZepMJ6E1YzjNp
	 E7d4iHuJSct9d7X91541CGB3xc74edzbKBcNRj/i3m8pDUSdcQ8u85MtPuxjB9cv/3
	 g6ve3DI33PAcKME41rVwxCexyfANfY/yJD/J2E8zEDXxieV9l+Y5zpTSujPNpuX1kb
	 NpY0IKffg3WvUdjAW9fasuRfN3gKsb5/Eh+F4nXnS8tO1H1aXCs9V4G4+K+WHRtIJs
	 p2yCgzzZVc/CGT+yGLqmD8KEJTdzF6nShFXACuFIMRtvE9Ar34D7f1fLhl7o7UUvBK
	 vwnNgKv3igW3O2XQ2M1XQrNo=
Received: by mail.alien8.de (SuperMail on ZX Spectrum 128k, from userid 1005)
	id ADED340E019C; Wed, 11 Jun 2025 16:40:18 +0000 (UTC)
Date: Wed, 11 Jun 2025 16:40:18 +0000
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Message-ID: <20250611164018.GAaEmxctC+ESUCvBNT@fat_crate.local>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
 <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
 <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250604093735.GAaEAT39KGW1KJDrjD@fat_crate.local>
 <SA1PR12MB89471067967E0A5F46CEE1DF8175A@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB89471067967E0A5F46CEE1DF8175A@SA1PR12MB8947.namprd12.prod.outlook.com>

On Wed, Jun 11, 2025 at 11:42:33AM +0000, Datta, Shubhrajyoti wrote:
> However the registers for Zynqmp and Zynq is different to differentiate
> Should the usage of quirk be fine code snippet below

Right, please send a proper diff - it doesn't have to be tested yet and I'll
finish massaging it.

Thx.

