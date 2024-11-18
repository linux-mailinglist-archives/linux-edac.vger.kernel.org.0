Return-Path: <linux-edac+bounces-2559-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343EC9D1BD9
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 00:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC30A282F3E
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2024 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD619754D;
	Mon, 18 Nov 2024 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="X35gIRXu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70762E3EB;
	Mon, 18 Nov 2024 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731972836; cv=none; b=LUBK5blD4daJDp2dCqEeLuK9veZo0D9B3a+9TIxuHVqLp4h3zSti8VlIhOtEa5Pd86ZpN/ImjyxI31+Dw9N9Sp/iUpQoz4qjKh/iwNpnF/ux79UDQbuEEvMou3HPUSz0wD57sLord9pVWi/MBIFMGDyGAeG0xru/CYYdPS3iFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731972836; c=relaxed/simple;
	bh=gzZt8AFMmEXfOg9BXf5pScgQat/Z8JhsZUZBei4WasU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXHCtw3uOUpVLSM+xSfe/mL/XTIiJ93VrSVIOio4ogLAchP+gwxw7hPmqznX1ClycyRTA8fc4rHF15NT5jLoPvBdYV2xKfV3J+aVlqrA1JXWKHIZbOIWBS80c62UPEiQ6zvNvAdD+uvFh7nzWupr5ePMAMIhUtDCv1g3qo8xxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=X35gIRXu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731972825;
	bh=yODI5yQrw/WFV8G/EAwEiA46R0zIcWLgUg6vGLKRIgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X35gIRXuQ5xgmY7+3mR9DcMSvhN7pqQOrVfIV15GqnMvaRLQDPcLtBVqCTo7AfC+M
	 d9opK2eW2HbT2cETixfTOMtwernsR7cUqIe5sldgjZVWM8lf4P9omubBW4TQHMPqCf
	 cdRcyi3a2YpErrRGajC7DBVLa4cPu7dihuXxtv6TdbZzcPsFi0+zp/tpEA6qIgUU6w
	 KHdR812KpqadQkoCZouV99HRZoaytkBcq0VEHjBZiL8rsWo/5Qghm2VOCzLAjD22vv
	 6BpOkcvzTxAlSLZQ62s9e1ryCQdIpl1NybB7pEP//4u1L7nfcE3Qd7XvTeM1ys3t5v
	 hG8etGZngpU+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XskTj28X5z4x33;
	Tue, 19 Nov 2024 10:33:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] EDAC/powerpc: Remove PPC_MAPLE drivers
In-Reply-To: <20241118104142.GAZzsZ5vcY_Vv3GvY-@fat_crate.local>
References: <20241112084134.411964-1-mpe@ellerman.id.au>
 <20241118104142.GAZzsZ5vcY_Vv3GvY-@fat_crate.local>
Date: Tue, 19 Nov 2024 10:33:46 +1100
Message-ID: <87a5dwi0bp.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:
> On Tue, Nov 12, 2024 at 07:41:34PM +1100, Michael Ellerman wrote:
>> These two drivers are only buildable for the powerpc "maple" platform
>> (CONFIG_PPC_MAPLE), which has now been removed, see
>> commit 62f8f307c80e ("powerpc/64: Remove maple platform").
>> 
>> Remove the drivers.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/edac/Kconfig        |  18 --
>>  drivers/edac/Makefile       |   2 -
>>  drivers/edac/amd8111_edac.c | 596 ------------------------------------
>>  drivers/edac/amd8111_edac.h | 118 -------
>>  drivers/edac/amd8131_edac.c | 358 ----------------------
>>  drivers/edac/amd8131_edac.h | 107 -------
>>  6 files changed, 1199 deletions(-)
>>  delete mode 100644 drivers/edac/amd8111_edac.c
>>  delete mode 100644 drivers/edac/amd8111_edac.h
>>  delete mode 100644 drivers/edac/amd8131_edac.c
>>  delete mode 100644 drivers/edac/amd8131_edac.h
>> 
>> The removal commit is in the powerpc/next branch:
>>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=next
>> 
>> I can take this via the powerpc tree if that's easiest, let me know.
>
> Yes, please do. 

Thanks, will do.

> I've been meaning to reply to you but then gazillion things interrupted me and
> ... you know how it is. Sorry.

No worries, I do know how it is :)

cheers

