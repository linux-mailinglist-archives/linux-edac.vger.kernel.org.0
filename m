Return-Path: <linux-edac+bounces-5480-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F957C70846
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3FD53589C3
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B79364034;
	Wed, 19 Nov 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWQ/r6Ml"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE030C61B;
	Wed, 19 Nov 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573483; cv=fail; b=dy0l6r3tmkMjrdipMsRJzzOLo3BpIRClppgojcvqAnTWEVzo3K3xu7ClXWw/Wqzzjv4Rst/YBvviDWWxJtDcRLfc1g+RJ/UqTQj946fM1/l7KcS78Azb9EU9KfYKl52LNMzHdsrKMSe5CD2smJGXmvmEb2Y6Vc4ZlfwKRVPGp9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573483; c=relaxed/simple;
	bh=FdhQw3La/XGFO9UiZB878jaZjlyIKJ9BTk/PumXvk1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H3Wwbc2qfL623aQen47aV7UL5edCe/TTpcEPjcRoivNsJVra3x5QVVhvAZA8k4KSfozXwHOhKgJcVVN4nlIgD/Z2ZncCKvVJqPdSZgTic3CO7VZwyCtpJqmJEkQNVvC9VPDHknlYkmdW1b6OLA4VYTM2rkVy6QM87Wg968jn7r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWQ/r6Ml; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763573480; x=1795109480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FdhQw3La/XGFO9UiZB878jaZjlyIKJ9BTk/PumXvk1g=;
  b=FWQ/r6MlCkCOTccyXQ7e8o8y7K7j0G6kYLp8dMytKNHZeETyFmKHOWld
   Th/st5gwSWnVdkraMprONXn/5Dyj3ADfdIMg+aaQFxifLQ4wbli8P7VlF
   PsT5b7zWhzlmF4UOxnepI9eXChdXM6zpIF1Lb21N+4GAh0zCfhsiMsFtw
   acIYUaid9k72PBdsNJSiQouzf6HRcamhG4a989+rEXNz+KTZ+Otz2/jyE
   Muo1xEupvYRqh+xm5r1bIWFE5/JjChiEzNJMX9zBUrG21e57LKsPfISHm
   kJwHwoCurIQE1BrnIrqS7BlpBO7WqSgYTH40ak6wfl0nHMamQMsuD2cUt
   w==;
X-CSE-ConnectionGUID: olLNqFvgQbWYSEJxGGD7fg==
X-CSE-MsgGUID: egt7BCcuRL2IkqMjzggUgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83248557"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="83248557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:31:19 -0800
X-CSE-ConnectionGUID: vn4ZGTdZQMW2NLrxhC/7yQ==
X-CSE-MsgGUID: 0QFklaKPQHKnB/Hd6lvraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="221763426"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:31:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 09:31:18 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 09:31:18 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 09:31:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pihwBfc/PL7pMzLMj/zYEK4rJcjJalP+kaY0eWCASeNQOfyQ7MTWzZQTnC7sn8P+Hulc2QKVIl3r/Z/Tsf2046HFk7cZp4nEDkoaUEK8ekAqjy2nUM+vAOixKJmCUnAZJ/eUt+qaJgXlL5HjroCdiVMMNA0waOH3BIKSuhWG/7ftEGBWu4UGA1EoOWMOvm0unNUQIyyPmX950rvEuBORBlmsqbjxY6vLu2XQu3TsP+an4lw3AVNKUrzwjIuKAqsGCkljs9iwgM1Ijf+GPE5EoZfbGkmSHHCrqqpLKH9/jrNFlUesoYTXZwR61DuQD9g6dTZ94qV2TZIKlbFhaKYOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdhQw3La/XGFO9UiZB878jaZjlyIKJ9BTk/PumXvk1g=;
 b=bGqDC6f3Fz6tZmmre322cUSClKUpC1ELhsXm+L+5geMQRkBZZPGVb91XYLG0+GisLySqEe0LnOGQL59Vz8Aaw99Yx+IXsDBKy2gd+0pD2Dv1ihNxNbxl8En1fASnZVavKimFufEkOSvL+JpsnpdCws7oILqht3A71qLiFg6KnsPO1un/BpWavsbdEGy6/2ElZfMAtsm8uCbDCeHiJ8BoUCmQqnfxWK1uhFUchLXotYF/EVSdMwL7062GnLxECAm+VRDQmCQZN8kw24YlaZAYbtriRpXf0nztzguJvNxr74RGuJl1HNwhIm47zrDngHVi9vjbAZZcMeLLuwCGsscMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 17:31:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:31:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel
 Diamond Rapids servers
Thread-Topic: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel
 Diamond Rapids servers
Thread-Index: AQHcWVvQIPH0ljuE4kmp+eSRIa5crbT6HnsAgAAXQJCAAAftgIAAAwsA
Date: Wed, 19 Nov 2025 17:31:15 +0000
Message-ID: <SJ1PR11MB60834BF8295536D1C6CE5C13FCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <20251119134132.2389472-5-qiuxu.zhuo@intel.com>
 <20251119152430.GEaR3hLonaUag36pFg@fat_crate.local>
 <SJ1PR11MB608363D7FBC9BF58DE3FFACCFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20251119171605.GFaR37VWsqvQX8sDED@fat_crate.local>
In-Reply-To: <20251119171605.GFaR37VWsqvQX8sDED@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB5779:EE_
x-ms-office365-filtering-correlation-id: 51b5fd38-432e-49ee-755e-08de279170fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0c0Si9OV1d5RW4yZEhON1B0WE5zdmhqM2kzMUxpbVJCZ3QwQWJhekZRdEtx?=
 =?utf-8?B?cGZ2dVdPVERtMzZvdTNTMU1TTmNRa2RHUlQ3MStkWGZITThsemNBTEZZbnlL?=
 =?utf-8?B?bEFheERzZGExc2VJMkYxdHh1YjJWQXJhUnNJTmxESUJ6YmlxRURIVW5jbm4z?=
 =?utf-8?B?bTVBM3NHVkpXZlQyTG9zbzFLbXNXOTY4OStqYmkyWkhBK3hmLzJ2K0FOeFB2?=
 =?utf-8?B?RzFEUkZkNlZ6enFINzFkQ010MnNLQWpML2IrOEt4VW9nRkZoUzU5aUgrNHRx?=
 =?utf-8?B?bjVXbS9mTGFIT3FkKy9VZnI0N1VDMGM0SlVxa1ZLU3oyak9BVEJSUVFsUndh?=
 =?utf-8?B?aytXZVpsbTBwOWZ6c0sxYjR2ZFlkSi9PV05sSTh5ZFdIdVdkbi9YRGt6M0pj?=
 =?utf-8?B?V1o2VEJPSStBck9vQ25TSFVQQkVqOEVvd2J1dVEyWVE1LzBVcWEvd3daam1T?=
 =?utf-8?B?aGpuSG90MzIrcjF1ZkVHUWZqcllJYno5ME9IbER5aHM1T0xGTW5zVWVSV0N6?=
 =?utf-8?B?ZkZzckJ3Z0xQWnFQSjNIVWcreFc2TDVKMG5EV3Vxa1J6cTRrSXB6bzJhNXNK?=
 =?utf-8?B?c1dtNDVQK3Rta243bFJqb2JuUHRrU3JpSnlsK1BDMUhJVjBtVk5YcFMzMUlQ?=
 =?utf-8?B?QVczRElNeEhZc1pEWllPdDV5Q1lYUnBxVDdqR3YrbUtVVzJuM0I2bW4rZll0?=
 =?utf-8?B?SGNTWXFSa0JZQkpmaGVvcXlsU0hHSmFaRkZ2OXRRekc1UE14Y2kreWlnTkI5?=
 =?utf-8?B?WVhhVC84R2FMaGtVU1E3Q2lNQ210SzRycEtpcnN2dVBqME8wM1lKc1hPbDUy?=
 =?utf-8?B?MUR3TWQweGt3UjJRbVM5VVZIeWNlK3JjQ05TNXlvelJvT2hlRVVuR2pvdGtJ?=
 =?utf-8?B?TzFJSExteVBIeGNlenVNVHlPcjVuZ1dHRnhKaGc1b2FSd3luOWthQlV2cXRR?=
 =?utf-8?B?K3RnMUJCakVQaG02MzhpU3h0UXhCd09FK0xPNU9lZmp6N283dnBtelVTNkZN?=
 =?utf-8?B?TWE3ZEtyZnVxU3dzZ00zYUNXVWVqQ3ZDeGRjVzZlc3pIVFNKSjYyWkwxb3F0?=
 =?utf-8?B?TUgyVkhNc0ZRSTcxQmExOHhUU2UrL3c4dm9wS0o3amZFNG1NaUJSRVFFU1NE?=
 =?utf-8?B?ZlU1QnJaclZCdTNxdGJ5MmtIUjA5eU9QN2VEbEJFUzBKSW5QaHR3T2t5WHRW?=
 =?utf-8?B?Nnd5MHgxVitSNzNrN0V5clV6K01OYWlITmsxa0tabklZelo5UlkwQmZjOEJU?=
 =?utf-8?B?bmw5UlNndk9sTVRYalJTdlhYcGdwYzVxRDhWUDdpa0RzeUZ1eDNSK3BkSmg5?=
 =?utf-8?B?eEpZeEF5K3ZDWTd5WnBJWjB0VXFjY2NnNk9jakVsRE41NmFhU1ZudS8wOGUz?=
 =?utf-8?B?S2t6U0FNN0pjRThlNmVEdTI0VUFNeXk0S2JubTBKNkVGdmFCbkNlV3VpQTZV?=
 =?utf-8?B?UGx2NC9RbElKOXFIckFzYVA0R2d2UFFKYndkL3QwVkdpYTMwQ3BkNmF1Rmcz?=
 =?utf-8?B?UTI1dTdGTS9OU3RiU2JtbzdORCtJQ1hBc1ZGY0RTdlBDUjlicTFFc2FnK3gx?=
 =?utf-8?B?UmlFMXRrREJnRis1Y01KWEdsWlZGOEk3aHozM0J2SFNNNkZoTEgzK1RFZjRQ?=
 =?utf-8?B?QTVGYmhhQU9iUWdBODZiU0czanFnL0RLdU5XMHVMQzlXd09lOEZZK0RwNHhi?=
 =?utf-8?B?RVhzL05kY0NJbk9leUJvelljOHRoZFdJbTJvUEdOQ3FNMWdqbWdFaWJkaVZF?=
 =?utf-8?B?TlN6UDlaeE9QMWhFRGhzVzlhRGJzbk9vck1Xd3cxYW0rZ21CTENFWjA5S2Ja?=
 =?utf-8?B?MVpRQVA1cEpSLzYvUUQ1Q2laY3h0djhUSGFnalBmUTBmQ0I1TFJaa3JhNWhs?=
 =?utf-8?B?MTU2SDhKNzBOQXI5Ujl6M0dhWVI3VVZ5VTFMaWk0RmNkeFcyRWNIbng1dURN?=
 =?utf-8?B?VFYxVHgyeE9lckFpa0VXSEhoRlVITkt6NFJsT01pR05Zd3cvTVhQcWFWbU51?=
 =?utf-8?B?MlFETHBNNnpZNndqZ0RNckdqWmpMQURCNFhUZUlKRlZ4UnpLT2JKaGE5OE03?=
 =?utf-8?Q?ABdAUA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2ZzTytGQ0MyS1Z5andYQ3ZhVnVPd29UdmdRbVZhYUtLaURBakg2aHBXdHdt?=
 =?utf-8?B?UklrR0YrcVZacVUzSXZhMWI3TnhUMURCV05PdWc0dEZzdDdoTnU3SVc1V0h5?=
 =?utf-8?B?WHV4bExpNDFtRHpNSG4zMDczaE1VZ1BoZkwyU2pGbWEzc3YyWk0wNStHREJQ?=
 =?utf-8?B?S2lwUUlmeGh6aHEybUxuTG8zdU9pdTBEOHdjODVEL3lrV3lsRkdWZ3NZbHgw?=
 =?utf-8?B?bnBsS0diWmlXZFA1UjhwaCt0bmUwVFE4MmFDU1Z5RGtHaExTK0s2b3lVN2xp?=
 =?utf-8?B?cGxsbWhTNXJFM3FVVS9EMjJrSElTNllveklUY2wrVFkyRGJQWGhNRFdmMndl?=
 =?utf-8?B?Y2swR1p6Z2lQR2N1L2QwSTFTQWx0TUVVWjA3VDdzUlBobzVaVG9OL1ZwTDZK?=
 =?utf-8?B?YkNZNnVlbzVNMGRZRytJY25qMUJvWTU1YXV0bGxlby9nNnUzSStOeXQwRUJr?=
 =?utf-8?B?RmFvd2FsS1ZCalI1ZWlzdVhoZzJtVy9jZzl4MHViSnNYYWlGVk0wSklYMDlM?=
 =?utf-8?B?OVV0QjI2V0xmaGVQUSs2eHV3UG15VzlVZm94RGJDdlJqR2REdk9nUW44VWtT?=
 =?utf-8?B?akVMSk1rT2FrSExGR1Fjb0xBMzJIN1V2YkN4TTcydFlOOFltZ1VVdndkZXo4?=
 =?utf-8?B?cmJMcWw1SUFocm9SMHhzZFFpVTdodGVPelVJNFBDeW9ERUdjTkRneXBhNTU5?=
 =?utf-8?B?dkZqSzIxT243QS80c2hjYWp4REdoYk1FSWJrS29WQ3k3aG1SdDZSSUpzRjhi?=
 =?utf-8?B?L05PUzBoMENMM0xZKzEzN3FmS3JkckJab1pUSGloaDJORGtzRWFKeExxWGVM?=
 =?utf-8?B?OWlFTWN3RTNucEw5eUEwWTdwaWdCUHdmcTdjTExZbm50b0N3QmFqQzhSMS9M?=
 =?utf-8?B?b3RUTTI0VE5jN0wvODFGM25JN1hYZWR4MFF4MWhUSkl4N0YvWUFMSGF6cUVk?=
 =?utf-8?B?RDJ3ZE9tYWVPSlEzSGJSYzF1bzVhYmk0emlBVlRyZm5tRDd2cWtVRE5XL3Vu?=
 =?utf-8?B?YXo2WW5ZK1hJNWQvR1dWOEFLSGV3d3F4TzdJVWtTM05mbUlINHFwTTZUZVZo?=
 =?utf-8?B?eUR1WE93OE5laFdDdkdnbE12djF4bzZteUZuU0tIMWxzYWZUb0RVU1A3TW10?=
 =?utf-8?B?ajc2VXladVJ6aEM1bnU3RjlBMzlwUmFLNWcrWVlORWJZS1M0TjkwQ1cxejFV?=
 =?utf-8?B?bmVUelNTWEhkaVFQYzcrMTNXQnBNazNqRTJIYm5ab210RkpSU2xwZnBNYWUz?=
 =?utf-8?B?bmRzb1BPTllZLzhPdW5uZ2RqenlJS2djMkZ5TVFKcTZjMHdMcDVjd3Zhc2Vw?=
 =?utf-8?B?QThsdkxJbjBoNU1lSFIvVWJ2SnJ4MHJxYzNqUDA3U0twTHhPOCt1dWlMajRB?=
 =?utf-8?B?bGIvYXd5blJoNVlUSzF1dmtKTlF2czAvYUh0T3dVTUFTWmY1SFJvWXV0Y1FW?=
 =?utf-8?B?UmNHZVB3N29SV05ZcHQyUW1IcDVGV2grUzRYYXp5RUcyb1U2b29GdUIwYjJQ?=
 =?utf-8?B?ejNCcEE5Y0pZeHVUVmtFYTBidDEzUGhuK0dobUJRcHVrQVYyRTRvR3FseGtp?=
 =?utf-8?B?RWcrUTAveXFpT0FkcHM0TEh2UnczQ3RDcm5XbGF6RWJHR2Jtc0dKQmpVT29Y?=
 =?utf-8?B?QjI0VXJZVUxoVzRoT1RjVTAwQ0dXRVJsSkpNL3AxSklkNzB3NUV4Zm9VcWtK?=
 =?utf-8?B?T0x5enAwN1lMSlVmd003UmJadzBqejRpaEQwZ0pWNktaV0RCRlhwbzJpT2NG?=
 =?utf-8?B?Z21JNExMNEFqVlZEaWpMR2dUV0JqNTlpWUF2TWlScUFjbVhYZE8zUlBmS1d1?=
 =?utf-8?B?YU5EbUJKVEtxeS80YjVtaGx6YmdLL1JJaTdXdG9JUjlURURaZWFMalppNVZT?=
 =?utf-8?B?OXJPd1ZDc2xSMFpnOVlsRHl2UUtDOWNwdkt2NlRvQ01hR3Ira0NFeTdtN1dE?=
 =?utf-8?B?dyswZmVqMVhVNVA2dXptUUZHWWZNYjhDbmFHUXpPVnRMLzhSUVhXQ3Nza2JQ?=
 =?utf-8?B?MThiVW9XUUVpUnZrQmgzSFdLcHIyZ3FYRWRFRWFQa0hIUnlPa21FSmdBOE8x?=
 =?utf-8?B?RDNVWVVUeEQ5MnNkWVBiUGJ1WlIvUDA3enB6SUlqeDIxUEtuV3h4WWl3WVlO?=
 =?utf-8?Q?b3esXZDRJmlHRJ4bcLRHttq02?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b5fd38-432e-49ee-755e-08de279170fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 17:31:15.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2abZ5xT5fy36zgWVYBOaggcRKz1DhhjsD1m9Kw/5EhDZZ9rYa1Sf7ipNeJ5+E9vI1K9nmpJB7RGsyIq74WCu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

PiBTbyBpcyBhZGRpbmcgdGhlIG5ldyBmdW5jdGlvbmFsaXR5IGdvaW5nIHRvIG1ha2UgdGhlIG9s
ZCBvbmUgdWdseSBlbm91Z2ggdG8NCj4gd2FycmFudCB0aGUgY2xlYW4gc2xhdGU/DQoNClllcy4N
Cg0KPiBJcyB0aGUgaW50ZWdyYXRlZCBtZW1vcnkvSU8gaHViIHRoZSBuZXcgdGhpbmcgdGhhdCBp
cw0KPiBnb2luZyB0byBiZSBkb25lIGdvaW5nIGZvcndhcmQ/DQoNClRoZSBuZXh0IENQVSBnZW5l
cmF0aW9uIHdpbGwgZGVmaW5pdGVseSBkbyB0aGUgc2FtZSB0aGluZy4gQWZ0ZXIgdGhhdA0KbXkg
Y3J5c3RhbCBiYWxsIGlzIHRvbyBoYXp5IDotKA0KDQo+IEl0IGRvZXNuJ3QgZ2V0IGNsZWFyIHRv
IG1lIGZyb20gdGhlIGhpc3RvcnkgKHBhcnRzIG9mIHdoaWNoIEkgcmVtZW1iZXIgdG9vLA0KPiBi
dHcuIDopKQ0KPg0KPiBEb24ndCBnZXQgbWUgd3JvbmcgLSB5b3UncmUgZ29pbmcgdG8gZW5kIHVw
IG1haW50YWluaW5nIGFsbCB0aGlzIHNvIEknbSBqdXN0DQo+IHBsYXlpbmcgdGhlIGRldmlsJ3Mg
YWR2b2NhdGUgaGVyZS4NCg0KVW5kZXJzdG9vZC4NCg0KLVRvbnkNCg==

