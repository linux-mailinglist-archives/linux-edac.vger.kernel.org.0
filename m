Return-Path: <linux-edac+bounces-5466-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA10C6D8DF
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 10:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 955C52D6C5
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24832E72A;
	Wed, 19 Nov 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="WYqar1UP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0E2BEC3F
	for <linux-edac@vger.kernel.org>; Wed, 19 Nov 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542904; cv=none; b=lqt6vB4T+vWABFC54oV7F85wqGbTbBBIuTUWkieg/TAl913/fyggehgjcv4S+jDft2nq7AJPNsRA956WO0UwfiMDV7/lQGam7kY36C0fUHQuB53EfvcEoVHZlOL/4fXwZrHr+hxeKugNRxp51Q7IrPhexv1+F0QOCvX6Lr2EYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542904; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=Ue+jty69Zm9GlxAeCGpaknr+ANO6b8yFN2412AczbvjnWL1JdZRXwxJ8U7gi2CCHDb64hXg+GIrgbzalM9S+EDtth0ylbrxk4U/8Uel1SkutxUbEWXm+bO1ew1iqXwbXwGIDxwqYyJBCQxYfE8WgLsAdf7sSQ/ewjpvuuqnyF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=WYqar1UP; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id CD99424C65; Wed, 19 Nov 2025 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542901; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=WYqar1UP3WRnZeEvHWuRu5KiQxAc1dR4MlUYQ2XKUMtV9vh8PTOBBllG3Yu3G9h/8
	 XUmGoDIwUa3m+RBNzaApUZSQeLotQ5OuLCtrLOH0vkqERpQOPgeDtcP5Dbcucm4Ox8
	 DiAxu2Z8dLSVFqaaRx3TggWnL3N+KbIwoXps3gxoDJ2nM6PCI/8MsBMtf9iLNWEJVU
	 uKS/gMQ+54d4uG+he6ZmRiaHXl0LDeVC9rcwGdWwFSFm0EEbklpkI3uJ3ENqJGV7Y+
	 eEp80ZZyV9IJpX5bb55/UzWv+mKHmLJdSwyOXZcRZZ7aCyN/piEni9qEy5ekYjYk/7
	 KnEPKnk3idyTw==
Received: by mail.novencio.pl for <linux-edac@vger.kernel.org>; Wed, 19 Nov 2025 09:01:03 GMT
Message-ID: <20251119074742-0.1.5y.z4jx.0.g1np6bmc84@novencio.pl>
Date: Wed, 19 Nov 2025 09:01:03 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-edac@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

