Return-Path: <linux-edac+bounces-3263-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984CAA4E3D4
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B290885460
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F78284B53;
	Tue,  4 Mar 2025 15:16:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98028FFDF
	for <linux-edac@vger.kernel.org>; Tue,  4 Mar 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101388; cv=fail; b=NOShkR3nkh+9iHta8PryHxny76RNLM1z2ymlLSzTJz8uSYtS8jkqDqlERE6UM33k48spbcQoNKuNuNwBOo52VhLmyk9j6D0cfLM4RSjRdt3+1SYWfRuBuY8Pi9d1Cb0TBLVtrACsCZ2yoYj3kqZLh4jLs9Wv68studK2HIqdBic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101388; c=relaxed/simple;
	bh=Q140J512fl+FeFdkGEjwsUDtH0BF9JSpJtTf4QOgqro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FDS1OSC9pnHfgsubWNmu9sgPstql0jpQX//mn+zQowjVTv6bGWirffDXSXAVPT8gR9wH0kdYQV+ym2p8qeoU4x6I6iOKFqoL+VVHxyKRrbiKAsgyZ2oZOnd2ftS+w5lTC8FiQP3sw4+TT/0XLLk8476Oyu1jsff5DqAl8sDe6Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=185.176.79.56; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 9C37440D2863
	for <linux-edac@vger.kernel.org>; Tue,  4 Mar 2025 18:16:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fMq2xjwzFyfn
	for <linux-edac@vger.kernel.org>; Tue,  4 Mar 2025 18:13:43 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C80E742722; Tue,  4 Mar 2025 18:13:33 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541356-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 5D07142F1B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:21:54 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 347A72DCEB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:21:54 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A8D1891482
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E51F236E;
	Mon,  3 Mar 2025 10:21:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB531EDA04;
	Mon,  3 Mar 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997297; cv=none; b=tdR5lQNGrdVWS5SAWs5gQ4Z2b2aHEQL5QS/uLFmAdbQsRpPbJU+667KIzEz2mAEmA31HywegkJ1LfIMUKNi3SNnbFOnGEE1e/Q3xKCpPw+Rp8YFo+jCDY4NVBXP3p9dKF5IFNh5Fi8mX/u5YF2yvRq+OKlmx0mok/PnDt6Y4ruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997297; c=relaxed/simple;
	bh=a2xSJ3T1g8IXcDpYxc901qp4tAn/pEbOH9ZKAL1qU7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z447CwWm+yrqV3ZWc6vrIR8ru6Fb3td3ZKi0NGqXFJ+BIdXk4j8scitc9HTAZUhjU8UvSBMiCYKgLYyKTttgDxahUQoNz0PAh9z+IvwaNo2JgJGCx1VNb9OYMdj1mzbI/+H7e2Jha/R8+TiWx/nGZk7RSKZJkhKpUKrIdJGidH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z5vtd4j18z6K9SC;
	Mon,  3 Mar 2025 18:19:21 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 01139140A70;
	Mon,  3 Mar 2025 18:21:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 11:21:30 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 3 Mar 2025 11:21:30 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "j.williams@intel.com" <j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Topic: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Index: AQHbidw989DsJKt5skazfuISb8i7/7NhGsIAgAAbu7A=
Date: Mon, 3 Mar 2025 10:21:30 +0000
Message-ID: <ed550760111d4061869949c90598ff5b@huawei.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250303173538.000007cd@huawei.com>
In-Reply-To: <20250303173538.000007cd@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fMq2xjwzFyfn
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706051.84618@h656jBJYP7EPb3NQK28Kdw
X-ITU-MailScanner-SpamCheck: not spam

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 03 March 2025 09:36
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; rafael@kernel.=
org;
>bp@alien8.de; tony.luck@intel.com; lenb@kernel.org; mchehab@kernel.org;
>linux-mm@kvack.org; linux-kernel@vger.kernel.org; linux-cxl@vger.kernel.or=
g;
>j.williams@intel.com; dave@stgolabs.net; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 featur=
e
>table
>
>On Fri, 28 Feb 2025 12:27:48 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
>> specification, section 5.2.21 and RAS2 HW based memory scrubbing feature=

