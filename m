Return-Path: <linux-edac+bounces-5461-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73826C6A14A
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8E1672C99E
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F335F8DA;
	Tue, 18 Nov 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mbjw9enn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB435E525;
	Tue, 18 Nov 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476351; cv=fail; b=qycdKjwPjzTsQGLktLYC3cA5WMgXOHZT+Yls1RVBdFN4dEUdNpw9FKBmmcsIQZOOIMrTT9ETO447g0Wy5EWakEdVGsGXN6o6C3IRa502wdooMFWkAQcxgKmOluhp3jOSjcqUPuSfyb4Ul/aXr7l4jtXhERe9ZDxw16Y/vldVUzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476351; c=relaxed/simple;
	bh=/cXWPovtlIAuEn2T2iSaySYe67h3Ipz2hpxuw0OcJDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mA9NEft9ik3Ig95fVN/1i98V2n/jCL8AHAYpAgd8zFPNUOcn9FMO+KqzfIybpq3v5ni6ppf/TYk/Tau6WtExssE4Gr+1M9tRLMmBmeQ/VOzQAj+4rwYZhfkxIo5Oc/LaDsQHcrBPYE9P06Rj7FQNzKcNgm9yjDVVVaNud7fprkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mbjw9enn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763476348; x=1795012348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/cXWPovtlIAuEn2T2iSaySYe67h3Ipz2hpxuw0OcJDY=;
  b=Mbjw9ennm0233wGCk+YpP7IYrMGkdXE4UwtElEpgt/NtYk2QX3ld+pDa
   ZUFwdz1f3Vd24M4W9QL5ESUUZ3rCrWk3jqlXQGSCbLLof1LRsQXi3qYOa
   TH3cmcS+eXhl9EIzJCFoppfULbo0d8XOh8+yViYlW63cj+bIzfQPkJPVL
   C3qNEGgWFwwvVholot2FdkKayb2eKzMb3n+oGpiqZmjUFyVSe12UHjWyJ
   hLa1xf4J2515IFl4/VOqgPKakRcAxX8TlL26MoOuTJMrPS5LOU8Tc2iik
   1yTPPi2Mguu4YlgwB41zJpvznTvOgky5MAGVECBgY6MRhk9VC9TwJfLx5
   Q==;
X-CSE-ConnectionGUID: 3yK77kwXQM6Ka1BukTWOzw==
X-CSE-MsgGUID: KElJwO80TlSoWbyruF4fPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="53068138"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="53068138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 06:32:27 -0800
X-CSE-ConnectionGUID: Jpw5UDemTN+mR0sIf0v0fQ==
X-CSE-MsgGUID: taEYrmwESTu7x/VcHM5xdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195903688"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 06:31:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 06:31:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 06:31:52 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 06:31:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyrm7oZ1d2HihHl3nKNzhaNAFTih00JX6C209SNpy5Yej6T9VD++v6SrtHA7O+BmOMOcXQYexIi7N4j0WgwqcXlL4eDNEpzSaCyVpGb+jRPsj8IyaDrBVkW22kprmRI0ZWaHIrVyv51JY6c9dKSOTdQz1YqZoKQ2eqTkIu+kkcnksW+JT5jvHTzdXdRk0VnSy72P3+CLyXkBNZtL+ogbsN6P2ZcXnwGoYxXx9OQpDxxqdsmlOFOXbcB4mRSnQMem/NeTsx0teVwZDQUDhyjYdU7aL6dDeOnXEEjh4zWd92fPyoam9SjTbNiJ8wBiTPA0qx5wZphi9Ew3uvffSh1IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuG/c/BLIx07rlMgfrHWfgzNk3/nUh7hSwnRsppEpgg=;
 b=ju/Nm/Q96K6otUsHCcWOGjdHQo0UWWkTZhVfcy5Ybk4gUjtqAwjfzzrNrV9R9VjR0bCw4Qsw5hsHlso5s6BzFzcxv4U5/Uff1H3gW1bUrNToIEgKMgJJaDwjBsRDgAUP86pF1pWNf9AuAggJNWPz0kg478o3V6tgk3BUG+gzs6UU+iU08NakQoc4FTDfmL/29Hy1qWeibheV7jiMrsrSQiJAIkH9L4G6OEQ+6/IgpQUIcY8h8pyx72tQAznUMDFvLaT1XheX5UAeWNeN58gYcA1TOWjOO9cQmQLx7Lse52z8f2KM8gp+YpNy7lxi0U/AtrKO9fksim1vunZmktppUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH8PR11MB9506.namprd11.prod.outlook.com (2603:10b6:610:2bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:31:50 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:31:50 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Borislav Petkov <bp@alien8.de>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/ghes: Replace deprecated strcpy in
 ghes_edac_report_mem_error
Thread-Topic: [PATCH v2] EDAC/ghes: Replace deprecated strcpy in
 ghes_edac_report_mem_error
Thread-Index: AQHcWJPcQrGY26m+jUCx15uMAV3TpbT4fsqA
Date: Tue, 18 Nov 2025 14:31:49 +0000
Message-ID: <CY8PR11MB713402925BD00AAC0FFA51D889D6A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251118135621.101148-2-thorsten.blum@linux.dev>
In-Reply-To: <20251118135621.101148-2-thorsten.blum@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH8PR11MB9506:EE_
x-ms-office365-filtering-correlation-id: 3e3b8755-5f63-47cf-b662-08de26af35f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?ACKNpfeLUqT7a5yBwwogN/HJx5/xrZDPu6xFEcjh7G8ldVmyGQfYilxVPBtI?=
 =?us-ascii?Q?u8C6DkghJ2HTeruc0C0w0NbqwoA90jy6eyfFVXOfso4MMOfCZZ+0bW+36ep5?=
 =?us-ascii?Q?R4FJ8NhEHoWPiloPMSdcYJm69gmurMB9rDK8kKjocsjch/fy/qNPqasbyYsl?=
 =?us-ascii?Q?LgTn5l6eTHvtgJwk3Ju41udnAV0srM54UFK2eb3uvW88b6fojiyhTKJ29I0P?=
 =?us-ascii?Q?wur+HKwZcJvUQ+bcGfc0SQJbHNl4jnaRoQR/FDXjno+JmDLrCqlSGDORkkDA?=
 =?us-ascii?Q?XfyQqN7KT6dsORFFGXq5Zdm/Nn/t5lDe0Vc8mKrLbhzdVz/c0IE0vJNohN+V?=
 =?us-ascii?Q?jxpk1Zti7MdwI/TMhPVQ7Z2SRyOkjkOOXcKJXERY5fNKauodlj6+1rfMFmGG?=
 =?us-ascii?Q?096pvQrcrY6s1gG7uC489vFAhDCmSRxu4dHUKkvdI5D94yZNothHTOLyp4Jh?=
 =?us-ascii?Q?YF45wUwwFGSk9MhKFAai0t6aIuBaTG0Vst/vtf25+ICMv4qnBHU6u941HS8Q?=
 =?us-ascii?Q?7iXoAqSwk0SjbCFli07KwN27kRHh29AZvD5smoA+c72l6/K86tHeDQvvgaKu?=
 =?us-ascii?Q?arx/jKeKgAn/VH908q+stvnea8KAOYUKpIQ/M5kr2M2Orjd9eHgOWR3tKT04?=
 =?us-ascii?Q?xG0rjc7H6pS2fDVyUZywz8nodvQQx8qg91unL+l+lg9KIVV0x6wttTDWCMEH?=
 =?us-ascii?Q?C+YLqzj6Qj/r17lrFS3hJlsIfHBALI/xRmtQRpwP44Gpn6Y1Ulj8E5/Y60YP?=
 =?us-ascii?Q?a+Qi2hOcleEUAxycXSa69jOsP+AuT7S/HpXkj8pZCG9olhw0PQ9/QdiauxAZ?=
 =?us-ascii?Q?0oLq7tAqI5K0PMLyjfcXFW4YBwIYsqKkNUgyBtg7LZW3nu4AG8a12fC5DVWQ?=
 =?us-ascii?Q?gZ7K713Nrcc0tdBlrWse2mG+NiwVR/X7PVogeXgmqmkfDNd4HpdP/Y3nmhag?=
 =?us-ascii?Q?mP3xUksB1iZxNEQNMs2Uid64GR7S08xeNq3zda9AaWCZjUUbPzFV+FQuLBdK?=
 =?us-ascii?Q?zahbbX578sT0ACM7SjnEggi7KnYxfkrngRW6Z76f8ZwoeczJ71yXPdVLxxEX?=
 =?us-ascii?Q?Rk1oU91D5oI3evRdbGDRW9iLkV95dvxmbOX6/QM7Tcd3dOMDaxG4iDYqCoM7?=
 =?us-ascii?Q?FaspHBM7Png6sI4tNLNy+ihggzGFMdZuOTznrSWauzjp9f0aQcY3+y8923b8?=
 =?us-ascii?Q?9g9Pmy/eBU2Zwc5Y04+Nqmik3Zt+eFVCL8nkHATRoDPuAVmJLp0jSKjX+7hb?=
 =?us-ascii?Q?Xm6gVFUsguhGJt1zUCHeebs+mt1OcyKXK0xreIsCIbjhAhXIeDF06VBV8K7D?=
 =?us-ascii?Q?BCKT18Eyfn3qbqdGeMU2b+B7K00lBETib9f0oEG1vINTUerHVKaScC8dwml5?=
 =?us-ascii?Q?4pYrerZHCnBxQC8dPtLg+9bYNoilm/cJM4Pq0OZAEPGTNtDe1Hnk3fWTpYGU?=
 =?us-ascii?Q?mt4UqVRVW5M5LT+vm7oLarzD3Zh9D5rT+xSqmeLEzDHWXfq+9xR3mJKRCgLF?=
 =?us-ascii?Q?/CqhlesceHeMUF9JOVQgBrvoZFnxhWRYWoEUf4zzVGCK8bUUcsn3G22gCA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b+Iv3F08e1SNzKfw8Smfxqaj8WW+PFjqtV6IVyf6cqfIaMcdmTFUlfQfqf8/?=
 =?us-ascii?Q?HTbgVCN1VjeL2yE1ctIBKqHg2w52BpYLkYNOiG8qMHcYTsBtOFTESLvzMveV?=
 =?us-ascii?Q?ZqOpX5Ffgbqx9o6jsV0OqP0MqwDZnv/FUVlHuCTfrSEC6c/RWr62Rv+8LV1M?=
 =?us-ascii?Q?A7cDrICUdSjGkr/akgQDJlIIBr1GLlDS469Mj7C+Wr/FKyb6Z1ao0ZdjN4ZX?=
 =?us-ascii?Q?+cjUKI+wq4VBuRK2IExg0D4aDBy/d0ekbb8vYfULvua5nruRz3OSQTSdqJgz?=
 =?us-ascii?Q?LgPynbnrRKmAYnDzPfv0fJynHb9cbyyHrKAMDWwrZuAwd1dWeZTT3EwFndyd?=
 =?us-ascii?Q?L+DhPoGTbB8YGTAej3Cz2wIQs4SoUps733+oNdbedSM8kBgqT8/jSqPqcBUM?=
 =?us-ascii?Q?Eg+vdNxzEp6A5DCOhwve5PJSXH5XVUJ5LRBWjNgPZp9PExtKlmhxF35gQblk?=
 =?us-ascii?Q?wWCYmtHrvs4uzxzchDPxs+XGUIgdI4Re6cxe6cX9phldhuASNkbSO60Bv1Rm?=
 =?us-ascii?Q?YztkPQujrHwMzoMVPbVA62oUTelskHDeazd9YLjqF++WSAbL+XdLNukAXKQv?=
 =?us-ascii?Q?bqqFKO+uOi9eJgcrELFZn+URVFYX+KfOm8EajspvLJAcRD3IjQuE83fhnwPv?=
 =?us-ascii?Q?dubEJoeuDr1c6yHvDJgq0cfSxX8yXtn9wjX9kQBFI+E79M9K6Ci14MsKyNVK?=
 =?us-ascii?Q?Oh1LYUlRci1E2ebilunwb8Pz4s1bvuPjEn1pz0/fwb5Odg5V7423plIE5kSt?=
 =?us-ascii?Q?Gg4sGAp1mSrxH/52qIkRtxHH+qevvVlkyLpuESgNaXwd/OHwpreVoYnWXjIL?=
 =?us-ascii?Q?4O7eK1rQHCO1wPK5BBvl3shTFd6ZBlzNUAuvCoRnHwwUwBiU05BmVRIXPmSV?=
 =?us-ascii?Q?EVGyl0ELp00p7fQph/fviu2BUeYVSsrR4K71kC0IcPxSx+JwTJmGbBZnE+xd?=
 =?us-ascii?Q?yXKcyaloKBsluHItZejftGGcNomovdZTR1PFn5nIIfuig5YcGMgmeuIp7Zpn?=
 =?us-ascii?Q?h8Pggtd4U3D5CjhyeBIFYe5xtmq3SpOq5iN6tWXfXopbZbQJV8uxMXnozAUH?=
 =?us-ascii?Q?zh7MwXSXmzpGj59b7KX8RcVTfP73/7b935NmX6o5LevGF9O2E8ffYObIbiQz?=
 =?us-ascii?Q?1Nf8S1DQzpEF5cEx81yrnMN8JltXKkpDTuzXfvNrHDjI1Mh8wvlzc7fMXNdz?=
 =?us-ascii?Q?2IOjubWh4wMjnzdqoVO3Fn7OLs5m1XcmRKQKR9O7skLh8QUmlKVnTPR2hELp?=
 =?us-ascii?Q?c1NBziFusvFmgAweSZJXNcZk77sqlUDgW+9lDNmFDuzWa2uddF1TSLi4KWo6?=
 =?us-ascii?Q?rX4sxYrT3jTNmS7UkHegkDby8IKFQ4gY6mzBDpboecpqNdLaOuDwJs7/kgdV?=
 =?us-ascii?Q?xYVYTmrSIFV/nogDd62cWS/QL2p8PXeUTTAQrqQECsvNojt2bbhThv1ICUzE?=
 =?us-ascii?Q?quPEGzuWs2qrhScY2MYIvl4Bz/Md9WKYpNhYXMG/zy/pF9wzYbxWi7+N8EAl?=
 =?us-ascii?Q?xRPiKjdQpcGu4Lv16EsUe6TWeseMDkMZ0ADGFYo6LMRH0AjcAykrec4ol1hw?=
 =?us-ascii?Q?AtnlUjJNjga/ou0DzOyM6UNsbP1oz7bGVcozFNsT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3b8755-5f63-47cf-b662-08de26af35f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 14:31:49.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iN8cKnGLL4jZLfLFk8qTc/6WHStLpkWuZyz4L1vhYDhUADrfrKA0Im5BQSin6t3vDnV3Bc1nxdthXgyps2/O1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9506
X-OriginatorOrg: intel.com

> From: Thorsten Blum <thorsten.blum@linux.dev>
> Sent: Tuesday, November 18, 2025 9:56 PM
> To: Mauro Carvalho Chehab <mchehab@kernel.org>; Borislav Petkov
> <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>
> Cc: Thorsten Blum <thorsten.blum@linux.dev>; linux-edac@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v2] EDAC/ghes: Replace deprecated strcpy in
> ghes_edac_report_mem_error
>=20
> strcpy() has been deprecated [1] because it performs no bounds checking o=
n
> the destination buffer, which can lead to buffer overflows. Use the safer
> strscpy() instead.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strc=
py
> [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Update patch description (Boris)
> - Link to v1: https://lore.kernel.org/lkml/20251031114607.133523-1-
> thorsten.blum@linux.dev/

LGTM, thanks.

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> [...]

