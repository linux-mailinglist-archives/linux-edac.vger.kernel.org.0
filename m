Return-Path: <linux-edac+bounces-1783-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235CB9699D1
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 12:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5234B1C22F4E
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D411AD24F;
	Tue,  3 Sep 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b="xprcu+we"
X-Original-To: linux-edac@vger.kernel.org
Received: from mod.modforum.org (mod.modforum.org [192.254.136.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29B1A4E88
	for <linux-edac@vger.kernel.org>; Tue,  3 Sep 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.136.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358455; cv=none; b=Gb4CY40wGj4nQrG8hd7Gg6AkHUBa2yC6KyhkndZ9pO46MGYPYrXHmPsCZyKgzEXDDIOdE4u5v35H/vRu4Uft3zBfIgrbFdqNIxQH5s0U2IWlyxed8AdkiKUWABspjrGjcadIZFw8pw24WqZYCXqksioBCzLEVquCFZTEuyic8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358455; c=relaxed/simple;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VGzBzUEe334nPCCTskYxsfDG4wTdZf8/sUa7amsT+qTwOMKydTjxhKEXQVxdFHKxu0ZNE/5ZoxPTqPZ1WkZzCw0OEOvOXqP+GV42U6C7C1S7eReepdf8UhYQKquktdvtHamBtwmARp/bkj76XvoExGCVl6gGiB3nwD3BKvhBWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com; spf=pass smtp.mailfrom=basantfashion.com; dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b=xprcu+we; arc=none smtp.client-ip=192.254.136.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basantfashion.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=xprcu+wenUq/1m4Wzk41njVYzW
	7NenVXdVde8s6C2Mm7v6e96nNeG4I9iR3zLDbtC65vGtrQQZIzO3EgUCTVeKAFp+JsHPyD3lQzirg
	KQBu4UwvWpdjD9h4zTT9q4fCTYUFdkAcViyiAwX5BTJClLQXVCM0pI8nbHM4vmywL6laKZXI0QzMp
	MhtUlzDGIF7deEChnnSSmC7zVDRFJ8/46srvKZLR1tBN9GpTwDNaDLV35rAPI4aJxa2md3iCCjuPz
	QNNAgbJFyynW4Qx3HIzG/dEsn/fhe++85fVBeZ0BCkohMt9hZfsrQVuU0VfMJkC0rygLtGaus9HV/
	NgSDhCxA==;
Received: from [162.244.210.121] (port=49384)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1slQXF-00020a-MM
	for linux-edac@vger.kernel.org; Tue, 03 Sep 2024 05:13:17 -0500
Reply-To: procurement@mercuira.com
From: MERCURIA  <kuljeet@basantfashion.com>
To: linux-edac@vger.kernel.org
Subject: Request for Quote and Meeting Availability
Date: 3 Sep 2024 03:14:12 -0700
Message-ID: <20240903031412.35C300CB344421B7@basantfashion.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mod.modforum.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - basantfashion.com
X-Get-Message-Sender-Via: mod.modforum.org: authenticated_id: kuljeet@basantfashion.com
X-Authenticated-Sender: mod.modforum.org: kuljeet@basantfashion.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Greetings,

I hope you are doing great.

We have reviewed your products on your website, and several items=20
have caught our interest. We would like to request a quote the=20
following

Can you ship to the United States?

What are your best prices?

What support do you provide?

We are also interested in your services for this project.

Could you let us know your availability for a virtual meeting on=20
Zoom to discuss this project further?

Please advise us on these matters so that we can prepare a=20
meeting notice for our company executives to effectively engage=20
with you.

Thank you for your attention to this inquiry. We look forward to=20
your prompt response.

Best regards,

Nina Petrova
Procurement Manager
Email: procurement@mercuira.com
12 Marina View, Asia Square Tower 2, #26-01, Singapore, 018961
Phone: +65 641 1080

