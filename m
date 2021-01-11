Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF66E2F0B32
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 03:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbhAKCyL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Jan 2021 21:54:11 -0500
Received: from mail2.directv.syn-alias.com ([69.168.106.50]:32059 "EHLO
        mail.directv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbhAKCyK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Jan 2021 21:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; d=wildblue.net; s=20170921; c=relaxed/simple;
        q=dns/txt; i=@wildblue.net; t=1610333609;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=Kpggc07njxalOD7xAXB7pYwZ8FQ=;
        b=hCD5jb/YmtgzU6ICYnK1Qc4tr8YOcy7rLiy4UxviVKt7vOOIXVPus4JVZt1O1ZzX
        yra5dTqApfwa3LtrRDgeCvE9VIdpoupHitKmQ+jlbwEJgj9mnZQky07LdrslY0tH
        +utjkx+uEJVKtYlUH644KdSgdz0YurwWAxA6jbB81cUfLmIREYab5UQCKZAGMTl9
        zywCgh6cqY06lkKaxAJXYXLX4G72kHVBnnOB/R+AwvXDEn95GZH8EIoIO5xyOoHI
        7tkAn1wK67Zb8QOZWDx8B91pbgzvGGKpFSkcKPESJUEtZQacZrk3p7jpnFb72yI2
        miPcEZUW6SlL9IiHHbC1Bw==;
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=a7tOCnaF c=1 sm=1 tr=0 cx=a_idp_x a=5uyRkI3skegLlrM6tBwdcg==:117 a=9cW_t1CCXrUA:10 a=KGjhK52YXX0A:10 a=FKkrIqjQGGEA:10 a=pTz6eDbWlxwA:10 a=tUj3IukAssAA:10 a=IkcTkHD0fZMA:10 a=EmqxpYm9HcoA:10 a=8dZtI8s76CEA:10 a=cs2_pUKLLHIA:10 a=x7bEGLp0ZPQA:10 a=JWQAtlBwcF0zhxzL0cAA:9 a=QEXdDO2ut3YA:10 a=xo5jKAKm-U-Zyk2_beg_:22 a=9afDMuuuZj7VoIJXVRjH:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: Y2Fyb2x5bmNvcnNlQHdpbGRibHVlLm5ldA==
Received: from [10.80.118.9] ([10.80.118.9:53852] helo=md07.jasper.bos.sync.lan)
        by mail2.directv.syn-alias.com (envelope-from <carolyncorse@wildblue.net>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTP
        id 89/5D-05577-8ADBBFF5; Sun, 10 Jan 2021 21:53:28 -0500
Date:   Sun, 10 Jan 2021 21:53:28 -0500 (EST)
From:   Rowell Hambrick <carolyncorse@wildblue.net>
Reply-To: rowellhabrick@gmail.com
Message-ID: <1963277681.2787121.1610333608019.JavaMail.zimbra@wildblue.net>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [5.62.18.136]
X-Mailer: Zimbra 8.7.6_GA_1776 (zclient/8.7.6_GA_1776)
Thread-Index: AhT6SJK4MIcUti3EuH3cYkzCZq3pMQ==
Thread-Topic: 
X-Vade-Verditct: spam:high
X-Vade-Analysis: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuufgjpfetvefqtffnvggrrhhnihhnghdpggfktefutefvpdfqfgfvnecuuegrihhlohhuthemuceftddunecuogfhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpeffhfhrkffugggtgfhiofhtsehtjegttdertdejnecuhfhrohhmpeftohifvghllhcujfgrmhgsrhhitghkuceotggrrhholhihnhgtohhrshgvseifihhluggslhhuvgdrnhgvtheqnecuggftrfgrthhtvghrnhepheelueelheeihedvjeeiudevtdffhfevkeevveeivdfgueeuledvudetjeefudffnecukfhppedutddrkedtrdduudekrdelpdehrdeivddrudekrddufeeinecuhfhorhgsihguuggvnhfjughrpeffhfhrkffugggtgfhiofhtsehtjegttdertdejnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepuddtrdektddruddukedrleenpdhmrghilhhfrhhomheptggrrhholhihnhgtohhrshgvseifihhluggslhhuvgdrnhgvthenpdhrtghpthhtoheplhhithgrihhhuhgrshhhihihvgesuddviedrtghomhen
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Did you get my previous message
