Return-Path: <linux-edac+bounces-1870-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D7978632
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57E4B207E3
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC577F2F;
	Fri, 13 Sep 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="ULkfw498"
X-Original-To: linux-edac@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694C2D052
	for <linux-edac@vger.kernel.org>; Fri, 13 Sep 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246212; cv=pass; b=MPuakFwDgnSokWqYliG1bHwrxxk9+4KAaFStcI/EePkXRUm0YASw28MDttgmMREdxJrIV3F9qOLKrFP/8jPmjQnQhIlsJydusZiIb51un3584xvmwMw8s2Dm6UTMHo/c4uUjHCvCLJ8OBu3KmejWM1rUFdT7W+13YeR0gDYJksc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246212; c=relaxed/simple;
	bh=5w8M7m3HscGBZmRTCjQjVYfnsDArrKjYJGe+Y2MFTgA=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=HtZSw8k0hmilh9c3cpJHlP/olVZV2oYn4Ym5Bi8YHMrwy1LMBGPtItrVaY0R13MI06+iTKhvOvi9cMpZyQzAchVl1w35KwqEsXs6lKnOrDLOHHuhkjs9eFh7rRjBetsXyFyUrZQifUkJ89D6c5YgikBZzO40IVhOzFfJ16HiyRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=ULkfw498; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1726246208; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UPqdiC3rqCNgtS55lK8jtmucKgPTrPA9YE7WyqKvuojITCubtPB8MuyyO8YJ6g9glGKBSA9es1gXz0ZSxZfcOXUXsTxnU04zbJi78qGeDOezr/85JWU/SeZtWsu+FKNGxe2sMFimrx0RbN4ll4+sH5F/dI6cffDsfI59xz51n5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726246208; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=5w8M7m3HscGBZmRTCjQjVYfnsDArrKjYJGe+Y2MFTgA=; 
	b=gBOLra2EoExbPXHkCR9jf93TscbJXLesnevv5knurvANNodIZafCVBDvmnKH6vlMTuGrsug+6RhUvv5nPHRbfw0sE4h5WFyc2BnIYoyae70sq7Hv1uoW/v5fVZLLEMa8c5FjpD4ByC+c1dEbYPb5Rjc04DE0OhC6PBVr9t3HcOI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726246208;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=5w8M7m3HscGBZmRTCjQjVYfnsDArrKjYJGe+Y2MFTgA=;
	b=ULkfw498jOyhRyz491n+Ry5Me82adPDfToS87zaQI9bB1ZHQwxnTjMTAsHeK38wL
	Iyvie/6BMT41tNOTZD53ul0H/ncAarpU+RaM/wC4nNOxG6VLFMl21I7SlbIsUiQOHrn
	8YgC1NXxoEBrXeW9pltoCsCOOF4ljB5WsxuGQbpM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726246207471885.2297027241459; Fri, 13 Sep 2024 09:50:07 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Fri, 13 Sep 2024 09:50:07 -0700 (PDT)
Date: Fri, 13 Sep 2024 20:50:07 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "linux-edac" <linux-edac@vger.kernel.org>,
	"tonyluck" <tony.luck@intel.com>
Message-ID: <191ec4abfe4.ee5cf21f77536.5289498031536692169@zohomail.com>
In-Reply-To: 
Subject: Is it true that uncorrectable ECC errors always crash the system?
 (I want this) It seems my system is unsupported in edac
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227b1a1a050500f6e12a4b2459a0000dc61bfa298a0533d634b40cfbee32453d6f0871fcc36658526:zu08011227c90929342d9ebfb54240ec3e00008bf2fd6ddb4ecb60bb5350fbab956035a97d7b9912f83b203e:rf0801122c5731f033784ba852a6ba0b04000087601fc1077a0b8a370e47427d771a764fdb1e9bf5781df340024a31600c:ZohoMail

Hi. I just bought Dell Precision 7780 with ECC RAM. When I run "edac-util", I see "No memory controller data found".

So it seems Linux doesn't support this ECC.

Is true that ECC still works? Is it true that my system still will crash in case of uncorrectable error? Of course, I want this. I want crash in case of uncorrectable error, because crash is better than silent data corruption. So, do I have guarantee that crash will happen in case of uncorrectable error?

Also, when I boot Linux 6.10, I see "RAS: Correctable Errors collector initialized". But when I boot Linux 6.1, I don't see such message. Does this mean that I'm less safe on 6.1?

--
Askar Safin
https://types.pl/@safinaskar



