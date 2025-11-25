Return-Path: <linux-edac+bounces-5530-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28AEC843FF
	for <lists+linux-edac@lfdr.de>; Tue, 25 Nov 2025 10:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820253A6D34
	for <lists+linux-edac@lfdr.de>; Tue, 25 Nov 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC72DE71A;
	Tue, 25 Nov 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="tWLXEd2O"
X-Original-To: linux-edac@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF72C3245
	for <linux-edac@vger.kernel.org>; Tue, 25 Nov 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063348; cv=none; b=UtPhavruJVjvukulInROqLjxLLvslP+y6EFzj4LHVLLHL7WZMBH97fyOUNm0Wn90lPC1EkkO81NZouddora+k5QbLfEUBDl2q+WQTbFJy2jgsIvvKJ5cvuxNyxnp9r3kRI+vt5I9nU9Tq5d7dX8PNB9Arhe2Z3HxeMB2K/UFaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063348; c=relaxed/simple;
	bh=U7nEComjY2e2YunGcczdvtjizwqqMhv4CrkgLh/axMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEW//Oko8ktpHn2RfuPX31BOec3S/IGtIyAloEza5pnaaheTszKvGqEBHgmk5gL8qzxbMFwojiSK3Ie1xUnWY8xJzudvIEcb+/xkW4OW/lW0BIjU4F3XbE8aAvdI0DSwOKjLLCwjXdVwo8gDoyQYDXDk+oXhjI0XGIAvXaUIV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tWLXEd2O; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vNpSR-005kAk-Hr; Tue, 25 Nov 2025 10:35:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=9C9j2EwP+dfCKYDGUnBZKucdfkkvyKBJa+crvY0pd3Q=; b=tWLXEd2OfSPBUqTTSDCMALSLb9
	CB0121g6ZahaJLbG7XnJTz7kyuyUILWbHQHKyofFVC46/uzIL8d7aZiLj2bNe7HPr9oIHVS4qU+/c
	++XSu2r/kpGtbTfdMbWh3G2c01GgIUGuNb3mgvZKVeR4xE/HTygrAiP5WgnmWd/gXMWabftfO1by2
	FAPULHEnkWjX/+nlebIMxfK+nmb1kEiM2stWFD6UZDXsqiI8s857lygwZrHGKuy1UskuyqY1UKn1e
	d7e5QmHCM04KL4zIbJRDKNX7u6SB61RuO6YCmnRuOXIa1vIQ3+zZMe9lYhytf52zrfX9QKdJuO65m
	Z3T2+9bQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vNpSR-0003qd-1E; Tue, 25 Nov 2025 10:35:35 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vNpSQ-00Bj0C-0q; Tue, 25 Nov 2025 10:35:34 +0100
Date: Tue, 25 Nov 2025 09:35:29 +0000
From: david laight <david.laight@runbox.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 Yazen.Ghannam@amd.com
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251125093529.109c8e1e@pumpkin>
In-Reply-To: <20251124084011.1575166-1-nik.borisov@suse.com>
References: <20251124084011.1575166-1-nik.borisov@suse.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 10:40:11 +0200
Nikolay Borisov <nik.borisov@suse.com> wrote:

> Both LLVM/GCC support a __builtin_parity function which is functionally
> equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
> relying on the built-in. No functional changes.
> 

While you've got this code out on the operating table:

- Change all the locals/parameters from u8/u16 to 'unsigned int'.
  It will generate better code.
  Using u8/u16 only makes any sense if you are trying to reduce the
  size of a structure.

- Both col_xor and row_xor are masks (for the parity code).
  So the names are wrong.
  In fact I think all the 'xor' and 'XOR' are incorrectly named.

- How often is 'xor_enable' aka 'mask_enable' set?
  If set most of the time (or the code rarely runs) then if the hardware
  register says 'don't include these values' then just set the row/col
  mask values to zero and let the rest of the code just run through.

	David

