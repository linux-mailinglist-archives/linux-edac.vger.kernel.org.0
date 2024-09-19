Return-Path: <linux-edac+bounces-1894-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38F97CCF3
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 19:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0435D1F22C03
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931951A071B;
	Thu, 19 Sep 2024 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjJvUe22"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9019F42C;
	Thu, 19 Sep 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766188; cv=fail; b=Y8WXgUmEVS/jPkYQC4onguNwEHyHNHXpppE/IrXMhfzy6byiQ9x6QL2CwC3GOyjbcLjloXK07BIm4zTbh8R5o8bpcL3zH152uGwiZvZqYDIbU9ZGrZ5OF8A+bCSF1LkLF0WoMYuWVff4dR65NfNFOQTf+KbYXFyrbaAkNl8qAQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766188; c=relaxed/simple;
	bh=K9Q5V/QiwI1FyeLgpTmbi2aj/JKE29X3UIY7Ws4G7oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dj5DqRAZzug8iFkwGcYsR1fOK0dInDvoP75x+fRQa/v01/5s+eDuRBX7YHbquyZ6vCbRaE4hrp3QSp4WPsYDbhPxhsR8yz3aCeFjEP7gxOiBaB1Jz6U+C9j9wTgp5Vp8camFusg91lgOZ0qvkCKSOedD6JpmYX4Pq0aGIidCCr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjJvUe22; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726766187; x=1758302187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K9Q5V/QiwI1FyeLgpTmbi2aj/JKE29X3UIY7Ws4G7oc=;
  b=YjJvUe22ohPafOQCLgEmBcoT9lkbp/btu/QwkX4av+4uQSqbndA+BCJu
   5kNRkWARwmtYLrCjrf+/+8v7A18WXD8OoR+tiaoJQlz5OMfCDh6d488lI
   9FroaYbTdJ/Deax54am7hlXmIHThsgsiY0eOMGy+c+xkd1j4QkVflZACK
   dJ1ldAVaASWfO1FEG4RmzlSeowMCd+UsNSwZq7W/Rdzp2k2o8FlC62b74
   e9Aa7DYMWj29p1tM5HKxOSBd0s5KNhIJw1WheT6AVBLnIeWn8eJ76Zrah
   R1uw3f6UXuIrOlOl7b9dzKtAACGVpkXD+VPInAil5x0YsWXxIJGwXYhkS
   A==;
X-CSE-ConnectionGUID: Tfw25T99T/G+Vrlp+xGD5w==
X-CSE-MsgGUID: pok7etCoT6CHetW1nxF8NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36319373"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36319373"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:16:26 -0700
X-CSE-ConnectionGUID: GaXY7D4PQQm4vmxyx3Bk2A==
X-CSE-MsgGUID: EwPbkzl4R/W/Lofbqxgu8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="70843022"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:16:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:16:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:16:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZNx1oP5NSX3J5+UEJNQ6fyeFBIGWsfVPY1t31f/Maghi2BOcaryPW36bTm4DG2vLimmRG5esbY7X9HvE8uO+MZiKoc4tAC3rkqwbfeeyll7Da7bVObaW+iJIsEWXIjtiIC/N/Jdboig/VeWvYhLOfxcHW7DgT5HOUCOcKOZhxWjM765T041OUnzBDuMMa5TCKLdfkdWMyNAp2yFkM7yhBdLGoFp9n1V9OIsB7GR8Fjj7IdrtbAmoZlIugw7i487h+T1GFmvMWNyIIETixlqrASHcVLOmrOtcEsx/EBie77PWXttNCBH5LyrqTNkAFCN6zEeskMXVy0yZt10rirQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9Q5V/QiwI1FyeLgpTmbi2aj/JKE29X3UIY7Ws4G7oc=;
 b=lsdkkkC/e9Coa1ZB31mZnKSirWPGfuessNNcXZWLIzGkZVFlzU6KSxWJmiGDfPGG8FfY0XMTFzjc2bOPyZkx1y5SnPVdedw2OkQ1SvAzOMYsOsnRDl7gifBAbw+efmwxngz0zOOI4j3xZks5zUXrd0DPa8JQC/1S/ueNEP04Ox9z8CcTLWhtMhzs7DXYwXJGXfrIt3Wi5bH/stPS7U/ZzCKQqQe5EkczWzKuvgTfYL+GYXtcJpudJA2dquc6TvCfLTIUHqd8HD/a0VTZXC4fEDP0+Y7EaVywdxMd983IqK0RCDufIiHO3WzBIFIIiny+bxAsJxySDca/gz27flyx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Thu, 19 Sep 2024 17:16:22 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%5]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 17:16:22 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next][V2] EDAC, pnd2: Make read-only const array intlv
 static
Thread-Topic: [PATCH][next][V2] EDAC, pnd2: Make read-only const array intlv
 static
Thread-Index: AQHbCrYGwclyJ3gphkGZhgmNJ3bJnLJfWV9A
Date: Thu, 19 Sep 2024 17:16:22 +0000
Message-ID: <DS7PR11MB60772289280349DCEDE6E7A7FC632@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20240919170427.497429-1-colin.i.king@gmail.com>
In-Reply-To: <20240919170427.497429-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|PH0PR11MB4838:EE_
x-ms-office365-filtering-correlation-id: df914bce-e87a-46c0-cf7f-08dcd8cec8a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFQwMmo2dGRvaS9Oa0VSQXJubjdLUFJJOHMrTkdTODhoUFRPY3dURGpuWXh0?=
 =?utf-8?B?RXFQSGp1cWlJdzlvYk5jUkF4VkRka3FxTS9DQTJtOVBRR0JaWC8veVJhb0Q1?=
 =?utf-8?B?alBoMVdTbzVRTmNJbC9TUmlaZ0xrZm5YeU4ydEM0ZHYzSC95aG0xOGZ3RlNK?=
 =?utf-8?B?dFlVYTNXRnR6U2ZrTGhja0ZDNzRuVHRiaFR0UGQrZVY0S2IzS2RIRnVva3I5?=
 =?utf-8?B?M1FJN1lsME9pR092UndURHcxOVg3c0xjSnNFWDdXM3NMUmxwZ2xqc1pnNjVa?=
 =?utf-8?B?KzdyaVlZcTlGcTNpSG1MUnpSeGtRMnRYNTg1NzI4QUZUR0plMkUwdWFZUzBj?=
 =?utf-8?B?V29lVVpHZ2RsS1hYOUpKcHg5UkFMcDJ1S2JYbERYZ3hGOGhRRTV0WFpkaHRv?=
 =?utf-8?B?cTRBZ2FUSHVTNjN6T3ZiYzkyQjdjWjlTWTNvOGg2VzF0Rlp0N2lEcnZ5aWZt?=
 =?utf-8?B?bTl5VFhMaVE5MUZNNXFDK0VwYTFtQkJDQ0N4RTFtcjFiOW5LMWI3TEIzTmdH?=
 =?utf-8?B?N1lIYUxMYTdHNWQ0T0tMdzBPNmFrc3hWSExqbE5taUpOWUU5Qy9GbTlpWkhj?=
 =?utf-8?B?Wm0rK1FCbzNVOUZVUmxOZ1dsRXJ4T1NnRlRyS2h6SnJ3NC9XbkxnYXdKUE91?=
 =?utf-8?B?Nk0zZHQxUHNSR3puNlNjWUg0SWxNMnp4aGszZGRPWXU5d0JQMFBXVktzdXFv?=
 =?utf-8?B?WkZXcFRxQTBwa0tWYk53QVdnTHlOdlQycXdNMEk4dWJzdzVodCtKbk9weXZ2?=
 =?utf-8?B?S0xPY2hzSDd2RStDTHpJYUIzSGhTWjlqNzJ4Y1RuWWwyM1NtYytLN1hZZkpJ?=
 =?utf-8?B?V2V6QU9CMzNBb3RTUDlqTVoxcW1mUndFdlBUWHAxSFFJTkpYVXYwSVJSR0Fo?=
 =?utf-8?B?TVM1UUxFaXVUdS8vRExCWkVOek1GODVia25zRkphNng5S0ZvcTJhUE9NNW41?=
 =?utf-8?B?N01DUU81ejJBWFRyUWNwWHJGcFRHK29UUU5zOXVQZ1N4MWlLdzFTM2hjempv?=
 =?utf-8?B?dkNnWTFOQ0E3UUxmeDl2NXllaE9QbFFNcE5XWUZ6S3d1K0tqNmhTUUxuMEFk?=
 =?utf-8?B?amJYTG5wQlNPZXY0clhTU2E5UlhjTytUeW5Bbm4vTlpralN4Y3lWa1hVSjVD?=
 =?utf-8?B?R21hRnk1c21WUVhoS3ZPdUR0cVFxNkpoNkVrUWJ2dS9HazFpTXJ6elNhT0dF?=
 =?utf-8?B?T2d6UkVaTEYxeHlmLzMwZXRCWjQ1TDFrb1YvSFg0RWt0WFMvMjJnd0dUNmJG?=
 =?utf-8?B?Uzd6Mm55YmthQ1NzWHRYb0k2clN1UVJucjhDVGhMT3c2dVhtdXZVWFJvamw2?=
 =?utf-8?B?RmFhZGFPV2J6d2pVdS9TS09jaUVPUTFxbTlLbVN5UkZyZlA4dFdwcm5aT2Iy?=
 =?utf-8?B?Q0gydzNjMm0wdGVURVI2RzhEQldKMlFrSnUrSmRTNlREVG1pRG9sQXF5YWJR?=
 =?utf-8?B?VGFnRG10OXMrOEx3bTEzWTl4MVltYllJazhsRlQydm9QcTJhSzNCU2hicmlD?=
 =?utf-8?B?ZlZvTDhyN1dreVFSWGdiN1dxUnhDMVNMdllvY3J4M1NDeGhoL2dNSWZvUG5p?=
 =?utf-8?B?azIwUmxRcjFJajNPRGpqWVFWOUM0TG9yZ2IvNml6NVYwam50M2ZQdjVjbmRR?=
 =?utf-8?B?YmkyalY5SElLOXV3VEw2YXh0eUFZWkZYZmNScjh5aUNpTXZtTFQ1MGNJMnVF?=
 =?utf-8?B?MGN6U3UzbHNqUjRJc0h0VTJtUm1Yc1JEc05iZ2dvU05zQ1J6Z3RacmVhcE9n?=
 =?utf-8?B?azc4RUoyZm00NEpqV2MvTVJFc1BsTGl5ZlBaVENyNXBVMEl1UWQ5MHhjK1pi?=
 =?utf-8?B?R3pCOWRMV1ZlYUVkVEdHN3hIMXBwQWRXTEQxYTAvSUZoTm5seVllazB6NEU2?=
 =?utf-8?B?d3k3QUN5a0t1eEN6RDVHVGpaTXN0R0VmclViSk94Q2treVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0MxcklDTlczVFlyc0NFQ0ErQU1lTVVEb0NMSksvb1VlODFXa3FnTWt3Q09U?=
 =?utf-8?B?SXlhamZxRG1CN2RCK2hzd2o0bWVPZWVXc09zYXpVdktPR2Q3ZW0xRGxEY2Rn?=
 =?utf-8?B?NnN2Tk9HalFRYzVvMmQ1Q09KSnR1UVBrMEdSVjQ5bkJ1blRvRGViOWZpblow?=
 =?utf-8?B?ZEhuSE1PaER3RFVBSmhNa2l5ZGpxNXo0aW5NQUc4WFpTOWZ3Tjd2bTRLdjRM?=
 =?utf-8?B?a2UrTExZY0l2RUxBbHRHZDk0VXkvWjBHTlZJeTF5R1BLcTJKUU1PQUdTUWhs?=
 =?utf-8?B?SVI1d05iOUlHVFE4aloxbysxT2NrajZSZmpLalU5NUZ6UDNScHJPRzQvbEdQ?=
 =?utf-8?B?NWdHMDVNTnBKNkdMYkRWbVFOOFppSXZrZ1VPcU5CWlNSTUVhbFN1WUxQUnFN?=
 =?utf-8?B?YWNzcW5lYWs4ZlFzaGFXa1pnVGpTZUlIaitGcWtzaFdDdGR5MWRia2t6S2w1?=
 =?utf-8?B?bUc4TVNpanFjV1VvTU9tNmVPazIyOVR0enhCYUwzeGpPL21WMEdxUitWUk03?=
 =?utf-8?B?di9ZZ3g2UGR1SjBocXJvVGQxbVRNY2NBZkRxZGZ6ZDdMSTBCdWJ2czFFUnhB?=
 =?utf-8?B?bjNOUUc5ZmRRVFo5aDNjZ1JPYVVMd1plTUYzTGxUR2twWUFYVEF3OTJEYWJV?=
 =?utf-8?B?Q0plKy91cld1cnBXZWwwTFdnaTN5RkFKWjFSalZNMkduVkx1UW14YWFOM2l0?=
 =?utf-8?B?enZsbGxxODZkbHk0OG5zL2wrZlN5ay8vWkdhUVBmdUlBczJxb1FuMFNTOEFz?=
 =?utf-8?B?dmpBREFHQVF1czYwN3NKN0lkVzBFdTFqZnJHNERGajZiNk96b0hJbi80MUl1?=
 =?utf-8?B?V2ZKVG8xQkdyMVFCaDlzRTloT3VqZG9BS21BZ1cybjNRYk9aM2oxZ1ZjcjBH?=
 =?utf-8?B?cGJUWG40NEhUanhoendGakpWWUFxdHZWcHpWcnp0cEMyTXFQdWtNMmc5TVBL?=
 =?utf-8?B?cWNxTzlSZklMNFE5NnVvdUlCNlhBRzJFL3RSWEFXSmNkOGpjVnJWWVF1OWpp?=
 =?utf-8?B?MVpEbDhvbFZhbjdnVXhJQVg4N0lQbG1aT1hGUThFUUppU1RzNHdEaVEvVExu?=
 =?utf-8?B?bWRuQ2dPa3Q4dGJmUG93NnRnYVpDdHdCOC8vN2E5Z3JxdW5YaW92VkdGV3RE?=
 =?utf-8?B?bTlZdmRiSFI0T0tJdE5SaFRaWmtWeWRnVTU5a2JBZ2syLzBtYTdBR0tDcytT?=
 =?utf-8?B?UlQwNlJuNk1xczBUTzFiejZJVVUvSHhDU2YzSkVOb2VpeGdMRXl0YUo2MTdT?=
 =?utf-8?B?b2hoRUZtbElLK3dNeWNFdW4vcUxkSDFyMi9vQ2E4YVNvRzZtTUpVcTZiemp0?=
 =?utf-8?B?UzM4alJzU2REL0RhUHFMTTBXSk9FYm40KzByQ0xvUUpiYWFLTHVoNmVjUjFx?=
 =?utf-8?B?UnRpNS9sckozSFRlSGF3Tk5lVHV3dDd4dmlJVCtUTnVuWXBvdHZXeVpJVVMz?=
 =?utf-8?B?UitMUTJ6MWNDL3VMbEg0Z3ZSeW9LRytOeVJMc3p3MjA3UzROQlc2a3FsUmx4?=
 =?utf-8?B?RzNVeGk2c0NsU2U0NDdEb1dPNHRSbzNBOC9jNnpONkcvODN2U1Q2ajh5MkJ2?=
 =?utf-8?B?L1RCcmRoaXArQUFoVytWL2VIR1YzS2dNOTZPYUU5M2UvN1ViT3lvaDhNdE5p?=
 =?utf-8?B?WldaK3JjNGY4bXhFUXRlZkZXTFlDUHNWL09wNUJ0Rk1DMjJRVUE2bXFwamh5?=
 =?utf-8?B?MGI1aTV6ZlV2QUd6YWNkMXI0bEZabnR1Z1NTMGFTSjl3STU3OTBlWXoxNkJx?=
 =?utf-8?B?VVJuSGxVL2RqK2ZpWXAwalJkZUNsUnNNU2tPQ2s3b0UvcGpRd2tPWWZua2Nq?=
 =?utf-8?B?eWZOTnRMSmlWQ3ArWC9qNHF3SFpQcWJ4MUtSNWUxSjVXNDNiakUwQU9HZ0hI?=
 =?utf-8?B?M2V3NEhmeGJyQ2tGM21zU3FOOGhGMG82TXhrQ0VDYk9tUDlJUUR0YjVDc3BP?=
 =?utf-8?B?aVQ1WHptOEZ1OUNNV2JiaS9leWdHVzBPcTFIUkVoTFA0QXBSZTZqRHFjS0o5?=
 =?utf-8?B?VVNGSFVxOUllVURPRkpoMThPeE1JZElHdXM1ejR0Y1MzaUt5ckQvUHh3OFVD?=
 =?utf-8?B?a25xemFmZCs4TGRRQUhUZjhwNTdJWk42NWlWZE80L1NJMkwzVmhuTmxPT2sx?=
 =?utf-8?Q?u7y2EZqIJpbtH5uQ+JsJr9NwT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df914bce-e87a-46c0-cf7f-08dcd8cec8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 17:16:22.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rN6e+fVSaDY9VuLxpHui86THLaFZw1/Mxfu40eWYz/4d0EMDsg7LxevYdEsd1vA/LA5tW5Ykt/byeHhYx13Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com

PiBEb24ndCBwb3B1bGF0ZSB0aGUgY29uc3QgcmVhZC1vbmx5IGFycmF5IGludGx2IG9uIHRoZSBz
dGFjayBhdA0KPiBydW4gdGltZSwgaW5zdGVhZCBtYWtlIGl0IHN0YXRpYy4gVGhpcyBhbHNvIHNo
cmlua3MgdGhlIG9iamVjdCBzaXplOg0KPg0KPiAkIHNpemUgcG5kMl9lZGFjLm8uKg0KPg0KPiAg
ICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAgICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4gICAxNTYz
MiAgICAgMjY0ICAgIDEzODQgICAxNzI4MCAgICA0MzgwIHBuZDJfZWRhYy5vLm5ldw0KPiAgIDE1
NjQ0ICAgICAyNjQgICAgMTM4NCAgIDE3MjkyICAgIDQzOGMgcG5kMl9lZGFjLm8ub2xkDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0K
PiBSZXZpZXdlZC1ieTogUWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQoNCkxHVE0u
IEknbGwgYXBwbHkgdG8gUkFTIHRyZWUgYWZ0ZXIgbWVyZ2Ugd2luZG93IHdoZW4gdjYuMTEtcmMx
IGlzIGF2YWlsYWJsZS4NCg0KVGhhbmtzDQoNCi1Ub255DQo=

