Return-Path: <linux-edac+bounces-3496-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD33A82A4A
	for <lists+linux-edac@lfdr.de>; Wed,  9 Apr 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3FB9A00FC
	for <lists+linux-edac@lfdr.de>; Wed,  9 Apr 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98B267AE8;
	Wed,  9 Apr 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crc.id.au header.i=@crc.id.au header.b="lBTcVXw8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mailfilter.crc.id.au (mailfilter.crc.id.au [202.172.99.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F82266B61
	for <linux-edac@vger.kernel.org>; Wed,  9 Apr 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.172.99.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210861; cv=none; b=MA7K+JLUXtMLffQu20pYxGeT9efWcOPgX2I4pHykxDZdOXF25WmQ1ntEpgQtzem0oWnvTe1REKyocD0qp90UukbqvN8tCKSdIabNxylpU1K9dfJkk6ndkMUi1XsioONn1k4CwvfRSEScilTznm7gcx89wSn4WYVr1ScYfez8FBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210861; c=relaxed/simple;
	bh=Lru4wj8Gba+ROYW1teETCbooX+D3xcRPxVPig/71apI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XTaqTYCpTgq+yIpINdCIkHGD6vpp+3tJGbCpTtmlgJylXh2LSRX0zbvz6qfUI4/dAkF+uFyU/9TREAqj6T+dG7lggZVqNPlpnSNgGsX4r/9BTZIvk/sCMx+UpIJpbzUpWa7K6uJ2XzFPMWaEhkBMOEP4WjS2RAtDd9dYbmkHciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crc.id.au; spf=pass smtp.mailfrom=crc.id.au; dkim=pass (4096-bit key) header.d=crc.id.au header.i=@crc.id.au header.b=lBTcVXw8; arc=none smtp.client-ip=202.172.99.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crc.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crc.id.au
Received: from mailfilter.crc.id.au (localhost.localdomain [127.0.0.1])
	by mailfilter.crc.id.au (Proxmox) with ESMTP id CB0DB61B99
	for <linux-edac@vger.kernel.org>; Thu, 10 Apr 2025 00:51:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crc.id.au; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:message-id:mime-version:reply-to:subject:subject:to:to; s=
	default; bh=cTKOv+bp+p/Xyw7TqK3APOp7dfQxM1NJL6WXvYH60Ro=; b=lBTc
	VXw8H3B4CTa8LkVnEMrmOVVNXZF+55cXQHnI5bL6gNyPkoESte2Fmtrh5bIr3rxL
	nRYXyphSvuiwslJF+jI7G2vLm8CxAWAxpn3jNLehXUKUASPGYcXbUIg+G6PFVKLq
	/Q65N3quSS1v0NngGOZsB8+eEx03DmwEsYUFTEMiqXi2At/cH6vn4NAdWTnPSOmT
	2qmUjE+mIVhpypq5WjuAXgt7ZeHNc75/c/+KdXhWl8qPe4mHKzd5zNpzS+r45GQ2
	ZSn6O3WVfC5eA6KEcq2KnSyO2hvbbXciW0zke/0CqbtG0UtPb346xhvB+Vqlbn92
	iWAAMzAhj5UIsrFVpCIBd6fZc8qPmHI222xBBwoiL48sS+ZOZ4cVIxlY/GhpgLOf
	lXJ9/VqqAV3GeipjkKNMvgnBQ2Wox/StQCOprni4y1yFoI2H5dh+lgfRJiwMGTVQ
	5bOUEyGH226ZLTEiH405Gepc70zG5VQclB60h8zWHTZ/QlsS+8roxGehkfIvVanm
	gWUDyxkKz0e95uP7CoPiNQVhfyZI5D7Ae/RVJwevEnqo7JI3OBZ+4YOyu1tZs1Ow
	U2tEtmPnJVtS8RCwMBoGg+flVtq8FFPWAw2xGAgLUmLyX/Z75+Xtr8sEXXEmLo9y
	8/R93m6PdjdOWlLWHHoIsQhFWZL3bGAePlLslbs=
Message-ID: <de007cb2-e64d-46b8-89d0-a064a7ab369b@crc.id.au>
Date: Thu, 10 Apr 2025 00:54:48 +1000
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-AU
To: linux-edac@vger.kernel.org
From: Steven Haigh <netwiz@crc.id.au>
Subject: Constant EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR printed in dmesg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Running Fedora 41 and the test kernel for 6.14.1.

I get the following errors on an UP7000 board running an N100 CPU.

# dmesg | grep -i edac
[    0.268437] EDAC MC: Ver: 3.0.0
[   12.870322] caller igen6_register_mci+0x59/0x240 [igen6_edac] mapping 
multiple BARs
[   12.870378] EDAC MC0: Giving out device to module igen6_edac 
controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (POLLED)
[   12.870433] EDAC igen6: v2.5.1
[   12.870449] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   12.870451] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   13.884222] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   13.884231] EDAC igen6 MC0: ADDR 0x807fbfffe0
....
[   42.810794] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   43.834707] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   43.834724] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   44.858838] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   44.858855] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   45.882673] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   45.882690] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   46.906615] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   46.906633] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   47.930829] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   47.930846] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   48.954877] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   48.954894] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   49.978806] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   49.978823] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   51.002937] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   51.002954] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   52.026878] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   52.026895] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   53.053282] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   53.053300] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   54.074900] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   54.074918] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   55.098973] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   55.098991] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   56.122925] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   56.122943] EDAC igen6 MC0: ADDR 0x807fbfffe0
[   57.146912] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   57.146929] EDAC igen6 MC0: ADDR 0x807fbfffe0

These errors do not appear in kernel 6.13.9:
# dmesg | grep -i edac
[    0.263456] EDAC MC: Ver: 3.0.0
[   12.854801] caller igen6_register_mci+0x59/0x240 [igen6_edac] mapping 
multiple BARs
[   12.854860] EDAC MC0: Giving out device to module igen6_edac 
controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (POLLED)
[   12.854896] EDAC igen6: v2.5.1

-- 
Steven Haigh

📧 netwiz@crc.id.au
💻 https://crc.id.au



