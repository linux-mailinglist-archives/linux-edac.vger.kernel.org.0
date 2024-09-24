Return-Path: <linux-edac+bounces-1918-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597AA984F59
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 02:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025EA1F244A4
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8F367;
	Wed, 25 Sep 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicksendemail77.com header.i=@quicksendemail77.com header.b="Xg+6b/ep"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.quicksendemail77.com (mail.quicksendemail77.com [193.226.76.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868261849
	for <linux-edac@vger.kernel.org>; Wed, 25 Sep 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.226.76.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223053; cv=none; b=VummDTbcNfXr0AtkhFOPJSJCigz2WIvzW0BnTOnMCw+KjHc2V2Z2TAs3vbF3nKwdsDMsjHJ5R8s9YTaDdf+GQqIfApN1TAtP5rITxbW3RjrPa03DtloBVgwGda/rd4EXZbeHUeqcCKGDdSbQxVPWyD7cVDZiRiAhpBjLZiVntg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223053; c=relaxed/simple;
	bh=mle2MXt2pA0tNiYdPCEobzP+i7JhM81HlSlRuk1ope8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UcrnbB7HbZVRWUk+sCuka+4ZSx7WuVcUO08iKDJICUWiGbB68xUdYoOgRAOcZ09YZnQXO/iixMeEDhNCqj6t1QD/Kcw9+TfPMuI/ynbzq1OQsgGbmPaNQNhmzaQ8Klcym8AAmZ5yp2RJjCCBGLdFUrcpJOVyduAajdjPIzRL8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=quicksendemail77.com; spf=pass smtp.mailfrom=quicksendemail77.com; dkim=pass (2048-bit key) header.d=quicksendemail77.com header.i=@quicksendemail77.com header.b=Xg+6b/ep; arc=none smtp.client-ip=193.226.76.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=quicksendemail77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicksendemail77.com
Received: from quicksendemail77.com (unknown [172.245.243.31])
	by mail.quicksendemail77.com (Postfix) with ESMTPSA id 2F46559021
	for <linux-edac@vger.kernel.org>; Wed, 25 Sep 2024 03:37:56 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.quicksendemail77.com 2F46559021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicksendemail77.com; s=202408; t=1727215677;
	bh=mle2MXt2pA0tNiYdPCEobzP+i7JhM81HlSlRuk1ope8=;
	h=Reply-To:From:To:Subject:Date:From;
	b=Xg+6b/epFJuWzgaYXqsX7SsRpiP66Nr77EbqIhNLP2n1y+faMRNo+2JDM2o4w8R2u
	 BxNgcUTH8yrq3AXDTg/Y+QMTU4ZRIDocfCUHaysvE4ZdzvsYA2OjQlfX69rV2xVc1/
	 NB+GTxuIahSX46ijbFoSLhTgneNp9HmgIjoBCKB7yMURZH4iNfXtgNxRSN0DJMUPRD
	 Uti1wClS5/iVoau4NpMLdVQoYEZcNOUrJ57Hpn8XzAGkwpB6qsJ7O+kBiy6qctz2xo
	 r0khq+xCitArIdi38U3tRVU1VvdTtKETvUXINbrAa/p+85vaCv66vOsrFC7awVbzHo
	 /Gl7LfEwRwYcA==
Reply-To: info@marvin-group.net
From: Marvin Jack<info@quicksendemail77.com>
To: linux-edac@vger.kernel.org
Subject: New order
Date: 24 Sep 2024 13:07:55 -0900
Message-ID: <20240924130755.47ED31688F4FD9B8@quicksendemail77.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.quicksendemail77.com [0.0.0.0]); Wed, 25 Sep 2024 03:37:57 +0530 (IST)

Dear linux-edac , .

Please email us your company's most recent catalog. We would like
to make a purchase from you.
Looking forward to hearing from you.

Marvin Jack
Export Manager=20
MARVINSGROUP NL
Zeekant 125 - 3151=20
HW - Hoek van Holland
Tel.: +31 75 7112400

