Return-Path: <linux-edac+bounces-4107-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04709AD3BA6
	for <lists+linux-edac@lfdr.de>; Tue, 10 Jun 2025 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F113A180C
	for <lists+linux-edac@lfdr.de>; Tue, 10 Jun 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177C1DA62E;
	Tue, 10 Jun 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=borehabit.cfd header.i=@borehabit.cfd header.b="lqxxiyug"
X-Original-To: linux-edac@vger.kernel.org
Received: from borehabit.cfd (ip160.ip-51-81-179.us [51.81.179.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE9186A
	for <linux-edac@vger.kernel.org>; Tue, 10 Jun 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.179.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567018; cv=none; b=V2shrZhdvLH/YhkHDpnWYLG5VWTW7eIh/IzZAhPA3ch0282J988zPwKbBMvTLsiL7LKUO3MFdTU+5jT9tXVGc//ot0swmS2ZJ9Ne2V3kcNiAZamkPYR2+ry++TrggK8g5YqyPErS8Orcn2StdsnDGWigMLeY4lV/pAmfVeAV2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567018; c=relaxed/simple;
	bh=j/qZ6nCFDOcbnwIbag40JF9HDzOLw0n9TJz9U1mz3X8=;
	h=To:Subject:Date:From:Message-ID:MIME-Version:Content-Type; b=SPObGcDE+Ob9eYq1muAy2Ol6WzW/K0L3ImzNOI7dSHgZT/XS3XCD3Yn2xnYi9OBDXdE6NZuNkvYhuPDKtQYyKl9P+elZCTQm9SXK/5U0/3M/1jWLrH1ckaNVK6qkdsxqweRUQsqWgtUVV+FXTiLWsikJqwdRxfVA2LA2czuEb7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=borehabit.cfd; spf=pass smtp.mailfrom=borehabit.cfd; dkim=pass (1024-bit key) header.d=borehabit.cfd header.i=@borehabit.cfd header.b=lqxxiyug; arc=none smtp.client-ip=51.81.179.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=borehabit.cfd
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=borehabit.cfd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=borehabit.cfd; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Reply-To:From:Date:Subject:To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CFYjPvEUim5mD5QwWelE+Axpgk7p2gwnF2M5gpb++Rg=; b=lqxxiyuggf3FFYn73d1Zztogr/
	SJ0gUOrIBiqG+TXO+st4ba+qhBkno93lDp/mgQe26U3wR7ROxV2bHIN4j6PV6Xq39ordKrNLR3LaE
	YeXhpydh3wsF+gahAB+OkB2O/X9ZNp6vndhv7dd7FwIyX3I8W4RUQF8CB7978Vh0GChE=;
Received: from admin by borehabit.cfd with local (Exim 4.90_1)
	(envelope-from <support@borehabit.cfd>)
	id 1uP0Iq-000Qhb-2p
	for linux-edac@vger.kernel.org; Tue, 10 Jun 2025 21:50:16 +0700
To: linux-edac@vger.kernel.org
Subject: WTS Available laptops and Memory
Date: Tue, 10 Jun 2025 14:50:16 +0000
From: Exceptional One PC <support@borehabit.cfd>
Reply-To: info@exceptionalonepc.com
Message-ID: <c89281415cfec4508c45fb0463653682@borehabit.cfd>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Looking for a buyer to move any of the following Items located in USA.


Used MICRON SSD 7300 PRO 3.84TB 
U.2 HTFDHBE3T8TDF SSD 2.5" NVMe 3480GB
Quantity 400, price $100 EACH 


 005052112 _ 7.68TB HDD -$200 PER w/ caddies refurbished 
 Quantity 76, price $100



Brand New CISCO C9300-48UXM-E
Available 5
$2000 EACH


Brand New C9200L-48T-4X-E
$1,200 EACH
QTY4

HP 1040G3 Elite Book Folio Processor :- Intel Core i5
◻Processor :- Intel Core i5
◻Generation :- 6th
◻RAM :- 16GB
◻Storage :- 256G SSD
◻Display :- 14 inch" Touch Screen 
QTY 340 $90 EA



SK HYNIX 16GB 2RX4 PC4 - 2133P-RAO-10
HMA42GR7AFR4N-TF TD AB 1526
QTY560 $20 EA


Xeon Gold 6442Y (60M Cache, 2.60 GHz)	
 PK8071305120500	 
 QTY670 700 each 


SAMSUNG 64GB 4DRX4 PC4-2666V-LD2-12-MAO
M386A8K40BM2-CTD60 S
QTY 320 $42 each



Brand New CISCO C9300-48UXM-E
Available 5
$2500 EACH


Core i3-1315U (10M Cache, up to 4.50 GHz)	
 FJ8071505258601
QTY50  $80 EA

Intel Xeon Gold 5418Y Processors
QTY28 $780 each


Brand New C9200L-48T-4X-E  
$1000 EACH
QTY4


Brand New Gigabyte NVIDIA GeForce RTX 5090 AORUS
MASTER OC Graphics Card GPU 32GB GDDR7
QTY50 $1,300


 Brand New N9K-C93108TC-FX-24 Nexus
9300-FX w/ 24p 100M/1/10GT & 6p 40/100G
Available 4
$3000 each



Brand New NVIDIA GeForce RTX 4090 Founders
Edition 24GB - QTY: 56 - $700 each




Charles Lawson
Exceptional One PC
3645 Central Ave, Riverside
CA 92506, United States
www.exceptionalonepc.com
info@exceptionalonepc.com
Office: (951)-556-3104


