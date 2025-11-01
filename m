Return-Path: <linux-edac+bounces-5278-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B303C27ECA
	for <lists+linux-edac@lfdr.de>; Sat, 01 Nov 2025 13:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165944E3982
	for <lists+linux-edac@lfdr.de>; Sat,  1 Nov 2025 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3B2F28F0;
	Sat,  1 Nov 2025 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmzLBTeX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1572D2387
	for <linux-edac@vger.kernel.org>; Sat,  1 Nov 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001963; cv=none; b=jy5FYz9OG5OPgeeZZqbJS8lsBfESsnDBam9MHxEO0JzpWbflDoF4+Y/TkDvlFxdQmSbx5VDEK0GNcwU2neDI3yEYOatBm8GdMDcuWA5MWm1ySsOviTjtTlDlU1ExQsYVZAKf/O5MzDtQrKOateFCKVL019yosSMk7LAn7SmDRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001963; c=relaxed/simple;
	bh=q0wnPO6LZkJSYa2KQQEDnYK/8cjLmnoYdIYFwsMDMPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hvLTbEceDI1UhDD42j9olclykBw79l4v0B5/2jYCR55bd1X8NDzHcbHtSdOhWZ5EEd0M9+rduZLyTAmkHVTQ2azdLCJ+tb9b3XGJw+43mv75rJK1oDgHHQaasgLyElBo3FK88m1k9y8V+9LBfki/1v0MiLNsYZGQyXmDJ+mdqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmzLBTeX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550eff972eso2192441a12.3
        for <linux-edac@vger.kernel.org>; Sat, 01 Nov 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762001961; x=1762606761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q0wnPO6LZkJSYa2KQQEDnYK/8cjLmnoYdIYFwsMDMPU=;
        b=OmzLBTeXxwLFjsX3L6AeIvN+QE5znkQUPjihIezEqdVLQgCOEtnglZ+2nKtxmn8mIF
         z9uXkjed9eo/ktbs4GvDk/2CrNqK6wAXwuUqogRU9tdTrKFrtj2ofXSM/BpvkMYHDwHe
         Wz76n+rmtQIyoUv3q+eRPyBmnrTt4CSN5ECP4QRruz8Drj8DRbC1tiGlU4cUvIjHKV/i
         KFkFbYygeMtKnIuxo0CUA//8y7T9aTcj/BTBu65SHVf2d3bJpuZP+BEmeuT3uumJPY20
         2y8OsQXS52BZY4uvWKJBDE/oX98smps0w5aW0vKIWGJcn1WwQrA5gKfKI/A0plPL6etp
         zZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762001961; x=1762606761;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0wnPO6LZkJSYa2KQQEDnYK/8cjLmnoYdIYFwsMDMPU=;
        b=LHhu5cmFbJSUwz2JC132zfDq07py1fN1vHyEkHwJXGVS3pi3+12ijd3C4MwgdVIwxx
         0ifMNXe3ZzsqbvF3iEvU9O2nbm4pWZIa8L7B1+XPo+1mHsnFzfiPb5lml2yuZ8KHUBxi
         MZHKEuPXCS8mFhlcA2N/PtOCgvF9youYxXVBuibxcpUssHTh4gEqHcpn7/DcNvinP9KW
         Wz7/z62qajCSditlataChLzAK5z7VX9saGpxOzz/RJMg0Jstd0fH3tcsqKc/3GNmbN1B
         nvx7eW7zGAJrKQYfQwoVSMWCoi9xlY5Za6oQLONCXs1nWrzRiLp9/PCiHvlJWVZZ2KVg
         C7fw==
X-Gm-Message-State: AOJu0YxIcAowPGfNK2dSlg0ag/IUepRORHWRF5xqD27V/LQfETMXypSH
	xQIpzxjGkfXdg7/F45mfBc3iof19UWgxD/XgIxatFKK/YDT2hyfvo+6H7pcq+LN1gEw4wXrqMSL
	IqG0pYi5/fC7j0wrfqAqIxGuxPf5FW37XZET0
X-Gm-Gg: ASbGncsE/shfsPehimhG4p8jOhoFbfNjO2JyhcR4xzXUm8X9EfLMQS9nYEgYd0jjB+B
	9scBTwN8SVb/e1PDx3VOEx7xdm/Qkrn3m9BvPNPbeIqtQbNKSNdF7cWMFIuGhIEdQ8z1SX87upe
	J9PIAy3WHAjiXQrbz8sr0ciAR/emByD2frJn+hYHN5GsBzZKzoHCwHmM4ilWmrs5dkJVEJhiYb3
	cdtr8feqNEjLh+RTR5Y1MfzPyi+dlLgSFy/jdt3HR2+Cw3KkAx+i44kNuoWzQZvZn3JiScxJXbi
	Xtg4DuCtF7bzL2PH8kHD3xUdof45TH86A4eixKws
X-Google-Smtp-Source: AGHT+IECTxEDYbXR5/YWjfROEd2DbX82PbnlXyKMNPDssRDbW4sB6vrDAV1stFo8/wkvP21NG8bXG9HbSIJj3s1n0Aw=
X-Received: by 2002:a17:902:ec8f:b0:267:cdb8:c683 with SMTP id
 d9443c01a7336-2951a49dd78mr107251275ad.27.1762001960837; Sat, 01 Nov 2025
 05:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vlad Ilie <vladflorin.ilie@gmail.com>
Date: Sat, 1 Nov 2025 14:59:08 +0200
X-Gm-Features: AWmQ_blh5_uNJsw_pUZvb5z29KWdjETm1QxEUWBYtz0RNt194g1IH59OC6dDVmQ
Message-ID: <CALR5YtV3tiH8azka+d8=QiucMBCUTC5jOguScoioaDZg+-h35Q@mail.gmail.com>
Subject: [QUESTION] EDAC/igen6: Missing PCI ID for Intel "Arrow Lake-S" Host
 Bridge (8086:7d1a)
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am running a system with a new Intel "Arrow Lake-S" CPU (Core Ultra
9 285T) on an ASRock IMB-X1317-10G motherboard, which supports In-Band
ECC.

I have confirmed ECC is enabled in the BIOS, and dmidecode reports an
80-bit total width, so the hardware is active.

However, the igen6_edac driver fails to attach, and edac-util reports
"No memory controllers found."

I've diagnosed the issue:

1. My CPU's Host Bridge PCI ID is [8086:7d1a] (from lspci -nn -s 00:00.0).

2. I checked the igen6_edac driver's latest source, and this PCI ID is
missing. The driver has support for "Arrow Lake-UH" (e.g., 7d06) and
even future "Wildcat Lake" CPUs, but not the "Arrow Lake-S" desktop
variant.

Is adding the 8086:7d1a PCI ID for Arrow Lake-S on the roadmap?

Thank you.

