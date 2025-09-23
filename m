Return-Path: <linux-edac+bounces-4910-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD89B97EAF
	for <lists+linux-edac@lfdr.de>; Wed, 24 Sep 2025 02:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDB31696F8
	for <lists+linux-edac@lfdr.de>; Wed, 24 Sep 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8E1A38F9;
	Wed, 24 Sep 2025 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="h9FRvT3V"
X-Original-To: linux-edac@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823B19E7F8
	for <linux-edac@vger.kernel.org>; Wed, 24 Sep 2025 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674595; cv=pass; b=TfTv+9oqz77U5rn0x28SKeOLhhQI2PPdImG8h1d2eP7WHMzKy2Zi+X5rhXCplxQ92re8D5nqn9+m2XUYu3dPWyx13ZeV8SQrKNXEyRYSfWpDAAvijNcjswIBybRrHfd5hCP1b50B4CetgNBGcFpHyj/3JoWEKVoDFN8JV5d2/f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674595; c=relaxed/simple;
	bh=XehTek+oz2qGP2niMN4+H+bSrbkt3bhwK5RINLEXWs4=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=kuZAhknIgvFosO4INsrZdB5DopNs3ZyaZNlRHCpPV+Jz7YCJFvdpyKd49/yEJ/x8pOMOgZze4MI0hpeC04i8Zoo1FlOhC7aDkK92/Eh8tLWrf/kvdjerDA3+ac+dnFD1anYS2yzYFc8QAJQ9p/Kw0fW51N1RRPzZDZEeotCyt2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=h9FRvT3V; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674593; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=enu5ZOp0674IADWJ+lrXx/KcDMtAq/1ebRzl7LIVGKG8sDSIXbgup2sEPxVlXJy9P3s+jXKJ+Gh2xwopRCcQOYmMB/dyl/B1qG7K+yzCe94dyuqZIALF7xwx5UZcTuXAPtsknZ4sd8VNxi3HsPF/5+oe0mYdoFTS290IfbzH66I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674593; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=XehTek+oz2qGP2niMN4+H+bSrbkt3bhwK5RINLEXWs4=; 
	b=t2KYwKKbyBABNaSiXfrL91wUxFuaE+QE5IYoXBa2IDnrxQ/Zib1MNK2Sh+iLeJl2irWmk7CFEqqU55H6CYq4XNXeflSbH1Bx3DCfneB8UKUhuZ3IDLeiFfgmg0HpeAGFdWVI/75JmrdkZI+xTFcgZqdy4fZBlKnmr1Br1teEzf0=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a725f30-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653599439.466154662896;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=h9FRvT3Vn8xMDzZeah9r6GqdCXJ2nXaSeBgw1OiOVqGxpz38pizQB8tIg3kKkwOVhuR6rY74Vchgy89P+Qtt9oZp/LnglaI5KHhQHAIEUFQG0CWig24eFw5LBda7aEf0yngrOEadXgFBDsaLie5APl/zMaASkGyR9O6/8K7XrC0=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=XehTek+oz2qGP2niMN4+H+bSrbkt3bhwK5RINLEXWs4=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-edac@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a725f30-98d8-11f0-9ce0-52540088df93.19978ffc4a3@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a725f30-98d8-11f0-9ce0-52540088df93.19978ffc4a3
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a725f30-98d8-11f0-9ce0-52540088df93.19978ffc4a3
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a725f30-98d8-11f0-9ce0-52540088df93.19978ffc4a3
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a725f30-98d8-11f0-9ce0-52540088df93.19978ffc4a3
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a725f30-98d8-11f0-9ce0-52540088df93.19978ffc4a3@zeptomail.com>
X-ZohoMailClient: External

To: linux-edac@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

