Return-Path: <linux-edac+bounces-2498-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9319C498E
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 00:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73672B2116F
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62F16F0CA;
	Mon, 11 Nov 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+vBNWJx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F8224FD
	for <linux-edac@vger.kernel.org>; Mon, 11 Nov 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366464; cv=none; b=HTi5yf1vibjRzmx1qkUBCPoFy2nA+wmwN8ESm37OGCfq20uURNxvoVX1zPNKgCRfOK+OFiUiz1IVGOeRd1cTWdWr6b0ySQLgJF5rEnWoWlUerjeHC6QJIjsf2KgowEXGsu/ulzoAPg3QzIFP3yaw1KUB/cdSIPdgGgxB1etQ+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366464; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=J/DvdYYm8nIUj+/WwxLdkQ9fxDbQ1E3JX0NfIh1hGRFHcPYmpWyAtCHax5+hR/FFFuAgaVmM4bqmQJ6OW3Dp9KP6631mwsJ0k6JkBSCcxqN/UbwAqRIOLEMBI1n/wUkDedIXzVGhOIH9++oIiJ8V/GcLFTkn1OVuEmoxe1L1ZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+vBNWJx; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4319399a411so47855005e9.2
        for <linux-edac@vger.kernel.org>; Mon, 11 Nov 2024 15:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731366461; x=1731971261; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=I+vBNWJxVbjgq8c9CtMSCkFOst5vctMmuwKN53Fv+fmu+/7HRG+o/TPHQJbtpiwlSh
         b2Tqv+6ywVqznxUVM3bbBKemt/QePdtGo0f6Lbf1syKiTtoSLch/uP9EBJ9ynb9qH3Ko
         8LFXWUzz3cEtrtNzYnn+RN4M+Ewqb2MCyngSponlxnzW88PCvRyfZqzQe0ddigRdhFlk
         meshNXKB3+AAt+d441F21Btbx9pKL+js+B/X0D6i7AYGzpGBQVhLaUEStGd+305flDnS
         crtyW1ALKhYrossugIauAYag6Z6X7Ji3+ZuZwvCtMcDpxXO0rKg0Td6nMhxr0N4xK0NP
         4pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731366461; x=1731971261;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=C2yexW4Dx72bVeX6xRO44GGCN/AP3tM7HFnj/TJE4Fe0T3jIyS21zDlIyYlr1zCrXS
         vQys+/BvuVwNVnp/ZHmlXLmR3F8XoWoT1k8wkZuLdx6OjxfGxS064o7OERmykmfCrC4n
         nD+UkVjNNaaskk++XCulOZW6/UqS9q4BNb14ndKOteeePGzYil/zMwKXqNeLFedwvErf
         gn87C5MO80FfuMkA7oV1Mlm/3WdeJCkYlC/6JjUp6hIfwUNBFkeUSAcd//AvScrVXcqa
         mKj/nnoYWGik8ie5nzWMTAZ2pVLXlwwf62IyXPAujcVE3eHA0s95yKF2qDXyRDZc7noJ
         BZPQ==
X-Gm-Message-State: AOJu0Yx5OmM7lAa4IDhi9v1NDUHP3rYMjWijNypyvT9DPI8HaCT1b5Cd
	We7iixzPhC0HMhuP+CZF7MAsh6pKOyJ+mczhO2yRA95QlZ/y1nGlG3MTleTR
X-Google-Smtp-Source: AGHT+IFXEqwIILyG74KtFZiWiyKNDAuoDs7MHSGcKwf7wRF2dna6sOuLJeigslIMY7Vk0PktxIDR2g==
X-Received: by 2002:a5d:6d81:0:b0:37d:5133:8cba with SMTP id ffacd0b85a97d-381f186d161mr12019840f8f.20.1731366460655;
        Mon, 11 Nov 2024 15:07:40 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054ad23sm186747885e9.13.2024.11.11.15.07.38
        for <linux-edac@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:07:39 -0800 (PST)
From: William Cheung <tanhashekh67@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <2334a15149cf787db5bbd9bf29d4998a030ae42ea5a9ecf067175e1be772de60@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-edac@vger.kernel.org
Subject: Lucrative Proposal
Date: Mon, 11 Nov 2024 15:07:12 -0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

