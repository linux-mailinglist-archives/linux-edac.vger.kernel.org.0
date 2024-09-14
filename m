Return-Path: <linux-edac+bounces-1876-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F99790BC
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B6B21BC5
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35441CF7BF;
	Sat, 14 Sep 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="DXr0NoB7"
X-Original-To: linux-edac@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058471CDA0A
	for <linux-edac@vger.kernel.org>; Sat, 14 Sep 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726315767; cv=pass; b=biKtrR6p7W2VEC75XbU3ESW8oXtzNWyBtV8Pnaf7jTivbb8GyQAReAD643jTVfnxyHYH1FQSKuq7YTT61kD2xySEWlhXr6HIvRZhmPkUSSTZ7niJRZufZrauAm1UAAcKq/NjTpIClgXRWV29e0uRg7loRt5W5sWAj+zqfqI6xso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726315767; c=relaxed/simple;
	bh=42EXMLcisJ8Z+L8mNlyM2A24o4B489hvVDGi9Y0YGX8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=foe29S03i557JtFbpI+fIPVdKWyI0h02zO7AqbPS8ZZk3//45qBSz3+itWcFw6eLdspOdmXIsh2mkgnVvyp2JRMkn0E35fg9coNwWbQT8gLG3xEz810PAYB005AGGLVNFaYZUpCfddl1vTgMydmidEMI+dosLxUU2oY4/nkX9IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=DXr0NoB7; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1726315762; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nUKw5VkvrK0U5dmOpuMEK3SNeEmS1xnLcAE8eXx2A4Ffdgpv8ZCFQbCie9QUNdb5xncS9SgITIVcyh2g6/sdLZgsQ/b4P05UWJIpPDsYkdEby0++A4WAeqKAiUAemtBCXWKh6Mt2yD7ELWnhQ7JWjjwAf6//j3eaBVOrKZyNtJI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726315762; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GNWchvDqRQkV67alPN4g3jw03Ts8SJ5WUAOm57KUp/o=; 
	b=i5tULCic6MovO5+DRdQbrur8eg8dVpOyPjrJzh3PHsSLm6xagKz8Lp68wj+9bwkMwQrJMq/THnk4CdG35yo/OTqUCNHdDSs9laPQkQox8VrA/wnvrlRXzkSXwJ5gN7Gh+ThNaCS5eacBBschLPqqE6rm3O/2OLgiyzBUDVZHpjQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726315762;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=GNWchvDqRQkV67alPN4g3jw03Ts8SJ5WUAOm57KUp/o=;
	b=DXr0NoB7EcB3F07UzhDh8gnvKYr0jX/IPv2T5oFgJYhA7SUqpMYmNNgktM9UM4jn
	fd+7X1Tees9ZNpvaicECQgqyif+HY197NJY2Tvv5kH6lykMrUvjnj/WS+c48ZqybZa3
	CQyS3kRYZQO3u16fuXlmjGAISCChB3niZ7j8jHMA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726315761187732.0486470175704; Sat, 14 Sep 2024 05:09:21 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Sat, 14 Sep 2024 05:09:21 -0700 (PDT)
Date: Sat, 14 Sep 2024 16:09:21 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-edac" <linux-edac@vger.kernel.org>
Message-ID: <191f0700e16.e4ac896383888.3692757560429165043@zohomail.com>
In-Reply-To: <SJ1PR11MB60836E226A36DD482E284796FC652@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <191ec4abfe4.ee5cf21f77536.5289498031536692169@zohomail.com> <SJ1PR11MB60836E226A36DD482E284796FC652@SJ1PR11MB6083.namprd11.prod.outlook.com>
Subject: RE: Is it true that uncorrectable ECC errors always crash the
 system? (I want this) It seems my system is unsupported in edac
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
Feedback-ID: rr08011227245ef99a967210550c76aede0000f861756c9f24e170399611bcaf1c89ee9d9b537349034ed7f8:zu08011227a9bc071f2b7d245eae6c405b0000edf2bd8d482592d5982a92b873d6e8bce613bc25ae9050b90d:rf0801122c9ffce0e957fb682f904af07c0000a58041df19f82795a3b7ff11382505499313a73ad66a6726015c6157d5b8:ZohoMail

Thanks for answer!

 ---- On Fri, 13 Sep 2024 21:05:15 +0400  Luck, Tony  wrote --- 
 > I'm not sure which model processor is in your 7780 system.

I have "13th Gen Intel(R) Core(TM) i9-13950HX" (from /proc/cpuinfo)

 > "Xeon" CPUs often support recovery from uncorrected memory errors.

?!?! How this is possible?

--
Askar Safin
https://types.pl/@safinaskar



