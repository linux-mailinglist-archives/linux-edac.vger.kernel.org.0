Return-Path: <linux-edac+bounces-1906-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB4697D4EE
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 13:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6133F1C212F1
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEDA1465B8;
	Fri, 20 Sep 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYbNKULU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98513C8E2;
	Fri, 20 Sep 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832706; cv=fail; b=INKhwJFJ9qg1dFWCUYW7LvstzJ56qCo+5maUF7X+ZT/U0E9mpFT1uHYt+3M4B7rkMv69r3jVxj4HI6VGbdmJoiqTvxzfjeo9WZlGyxYGt4koaifuqkZPyXOR5f6tMzYDRbPRFirvgNIn3J1eRjW1YIt8635ss7OwbdNIsrTqTNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832706; c=relaxed/simple;
	bh=3uXhNlWRvda+wb3JftUUR2QiHHpe84lPQ4Y33eyX03k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IiqTPe9hEQG5m3EYxD4al8H+H8sjz8gz6cbdyLhNF0Q7dFOzmJxBO3agS6Ariffkd75x+tnSCRGa2jUBTKid8YN5bmmDqT2sKCDOxi2dMH4pZ7EcoPWN3YXWgLSw95Un/s4twaTtHkmBcNOuwmJR4JF0nPF/cd5H0CnUcssUIq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYbNKULU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726832705; x=1758368705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3uXhNlWRvda+wb3JftUUR2QiHHpe84lPQ4Y33eyX03k=;
  b=JYbNKULUizFFmpgcSGxsJ9T897Z/WlvARAsqcMnazG5b5RydryUfGIAG
   IjpVVFmFADxPn4zsdxmn/q5smCFH6qouDwwB55WKNHSRyHqQBAFW9ES/R
   iUdbTfuWdTy8FRyqL+ViSm7gQSWP3zKHIADHlYsgpmb43sMlGVgDc4/7d
   wibL0+80qrrkeqMT5SbT3qqlYcTHsQn9BL6rH0vw61R8cB9541eeZtUNK
   +fkVxoSIWfe1b8LcTle1FpQ5JJFmcwBpdgAbEkSyHthsB+ObyiF7rdy8M
   81B/JDCVUlfLIMznHTzMGQtDagMo2fkq6gtpMhUHCsv+tMmQKFbPwpVhr
   w==;
X-CSE-ConnectionGUID: /zS3FWSaRJ2iKjULy163Ew==
X-CSE-MsgGUID: k3225Pg2RGmD8CHhA8+GSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36966528"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="36966528"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:45:04 -0700
X-CSE-ConnectionGUID: CEH4i9PKRiWOKsc736meAA==
X-CSE-MsgGUID: Hfme4rr+RpyPpRfYT9ib6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="107728220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 04:45:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 04:45:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 04:45:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 04:45:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 04:45:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 04:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4D8Mo9VFstKgzpUfmAnt1HSjSN2EhWXsM3rFADbaW7DNR7mbtuDUVUEIgyPzgpk0uVmmm70eParn0nVk8a4PTwBa7FXgIXrs5XH9N9+XyL1LO7ATm6zwrPJxFAp2vwo+g2TPQT1jW36oRF5i82gwECMfj2NrEn4mLhv7w9SkxaLYVGbTfv8JqNS/CDHQKTkMHEXHl4DWzDRHFeNxf3gcslsYjGQ3O2ldA+2biC8htmjaKQlvYOxrog42/ZLmn8yl2YaTkTL1/Kn55Kto4f9ElXL+w3aEpeUygq+LY20/2h4fuMi0J9zqYSdO1rXWh0rhf3d3EhXdXD3c7Rk7O+PGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uXhNlWRvda+wb3JftUUR2QiHHpe84lPQ4Y33eyX03k=;
 b=r8q1FSm2X8AYaZAHPpwlWeq8irqXpRs9CLblhi2j/BmTqm9xX0nqCzfqpfOUAQYnIszNYScG6d1tFMCFQO9NMPt1SAalLt5KjPsqJFy7y8LcKBwHV15G0GcnDddEGcRzK7OIrF/TxenjSS1Nu9kooY/wLryXcZroMtbrnP3q19tkBu3GvIvovU9G+XGPgip0NMKcw3xllE3+HYqojbp0LWFLL68imHwT4e6C3DNY4b+3LvwCcoQNpiirIUOM7VHHzoguODOlR5sKHHL3EctmMGAf9/SL57VpzJcDu0k4Zpo8Y1ajlODpX9XXaq4XFeNwTATh08dp88KDYGK4RaK2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 11:44:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 11:44:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Topic: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Index: AQHbCZVjPrbUzsWJXUSTGjVHYWY80rJgZ4xwgAAY1QCAAA/1UA==
Date: Fri, 20 Sep 2024 11:44:59 +0000
Message-ID: <CY8PR11MB713412D068F202057A71CDE8896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB71344BE2857EA522CF71DBA1896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <7a80b9f5-9503-45fa-bbf4-d0dfa97688ff@zhaoxin.com>
In-Reply-To: <7a80b9f5-9503-45fa-bbf4-d0dfa97688ff@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4682:EE_
x-ms-office365-filtering-correlation-id: 52dd1797-9bb4-4bc1-3f68-08dcd969a808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Uk1TK1FkeVdSa2FYblFiNEIvWEVVaGdWbTNvaS82a1E0VVg5MG5vYkw1VmxI?=
 =?utf-8?B?RUJLczZ2NWMyV3JZNjRFN2VJOXhSUWhCUVJaci96SS9XQm5PeU4vcjk3Uk55?=
 =?utf-8?B?RVk2K0NPdy9na3l6SGVFSUNnTkVSTHRZMi9NL0VnRkFqdXJQR1g5M2ZNUE5R?=
 =?utf-8?B?S0JCQzVPc3hSdENNQVVuRENOOUdIWktNQ3FSSTFWOHBqREZ6YkIxY2pMRXBq?=
 =?utf-8?B?R1dHQ1ZjTFdDUTB4Q0RjcGYrc2dsWnQ0VlVVOGFrL054aW51RDVzK2dUWEtw?=
 =?utf-8?B?cy9YQUN6ZXVaT3Y4M2kyUW9BUkIxcXNQYWV5a0RJczNDWFZtUE1VWjlHZ2sx?=
 =?utf-8?B?U2pnWlo4ak5vVFJtNlJyQjBGL2xkek1ybXBWSVQ0c3k3VjFGc0p1cmhRL1Zh?=
 =?utf-8?B?cysrZTRYL0Z2SzZQUk5qM091MlNmM3VoblVGbThJWHVZdWhncTl5dXhudmJQ?=
 =?utf-8?B?bnovU1UycWFtMm1LOHljaWp0NjlweWJwYzZ4bmErTnZmbkc0cUQ4dVRXNTIw?=
 =?utf-8?B?RjlVV2RKaytUV2JRLzM5eStqT1JZWWI2a0ZSc3hVakFGczBzdzIvdy9UTkVC?=
 =?utf-8?B?dWh2M3ZEYnhGNGpBY0xHS0wweis2L2Nrc0dCOXFnMERiWGhLSUpWVUE5M2xm?=
 =?utf-8?B?Qy9oVTdmMWpGWlJrK01PY1FMMFJ4bDV6TGxTNWVvVWlEYnhYMHYxc1lQMmM1?=
 =?utf-8?B?SFF2b2dRRXdBbDVvamM2WHV2SnAzb2xkNkYxb2l3NUNDUnNrUEhtREQ2ckFR?=
 =?utf-8?B?bUswZUd0ZEljT2xmQk9PVCtBTWFCTmlUVHhkTkNPOXNrdXhUc0s4WUFSYVAx?=
 =?utf-8?B?SjJoTEhuRVYrSlZNNmNqc2ZwckpURGM3Nm54dnR1U0NSaGpVdS8vTWRVQTJP?=
 =?utf-8?B?WHpPOTZSSEkrNHppOTByb08zdGpkMC83MGE1RnRISFg4bkNpaHNIeGxqSXU1?=
 =?utf-8?B?ZDQxaXA2eHR2N3JvZEluOHk3OFAwVUlGUUFJNkpaSG4zSmhPRFJBU2VoSGY4?=
 =?utf-8?B?SnNsRHdYTG5nUXlscDJsckRxck1YYm15Nnhkd09xejZNTXltVUowVjhkSmxP?=
 =?utf-8?B?YVdFdUhDbkQvSXphWEczc2kyU2N3VUZJd2psUmdTcjROYmxSNWltaHZPQ1Rq?=
 =?utf-8?B?b3J5VEVBRndjTlJvd2xyNUE3dTBMRVJJMjJBUnJndnJRbVgzM0tCelVhZG8w?=
 =?utf-8?B?NXJzZjZtUU1tQlVCbmQya3NpQ1lxZFpLUDM1Sy9EQTYveENJM0svZjB1MFVs?=
 =?utf-8?B?bkJETE9uR2txMkdwaDZZWG9Nc3VxdngrMmpSeEFtMGhKMGtmTSs2REhTNUJG?=
 =?utf-8?B?R1loS3JaQ3NyQmYyWWlvczg3UGt1c01mbGM2NEoxbllnUThmM1V1UG5pTWNX?=
 =?utf-8?B?NktFRi81ZzVXVlNNajNNRDNRUkN0LzhDSUdZWVNjeXBGeXBwOVdjdjMwdlkx?=
 =?utf-8?B?anc0dzNVdXJHZ3hGK2NJeUcwWWN3Y1hNME45QUZPU2hjTUFuWVVMQjluSkx4?=
 =?utf-8?B?MW9pMFRhTWI5anZ4R3B2NFE2VEtCbElRdDg2Q3IyNGNRNm1yMVlHYzloelZE?=
 =?utf-8?B?SENHOEZ6V2V0dmcwOUR3Z3AzeU0zYVBFbnZCR3AwQlJhaThhVU5IcytQYVUv?=
 =?utf-8?B?RThsZ3dWMkpReGR5bkVDQUIwSExtelcwVEdRNndnYzVvZHlveFEwT0d0K08z?=
 =?utf-8?B?Ym9Rbk40SDdaS01nMEU2bnBnQmZLQ0EvRlJKT2tDOXFaTDF6TVBsb0QxM1lq?=
 =?utf-8?B?dW91TFJLNHRmMXJHb2xDYnQ0WG1SaUkyQU92ZG1CUXdDbXpncjNESllkOSt6?=
 =?utf-8?B?ZmxocXp5SkRzMnJkWXRZUWdyaEJGNklGUVJWUGk2dTZoekR0UXBEVDZ6eTQz?=
 =?utf-8?B?MFVwdWdtTWVwRVl3MmUrd1dpU0UvNS84NjRkVnV1L1NRMytoL3lKczd2OFZn?=
 =?utf-8?Q?JIO5eJpaf2g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGNEZlI3cm5RME9ocEhIdGdPbEkzK1hsLzlGMk9PYnRqeFFOWVdwK2J6aldm?=
 =?utf-8?B?elNoUG5HdnZkeXE3dGdFZGVrMkpLc1lURjNtejM2WWM5a3dFU3RDTStRMUhK?=
 =?utf-8?B?eDZqUGZ5dE1VT1BnVnNYc2I5WEJyN01WcHRxMyt0V2xyZFhDZXVCekR4NkNk?=
 =?utf-8?B?d2hyN1JwZ2lySnV1NWdZa1U3dXVIc1hQOUEzNnRHdGs3Q2dmWittQzlNNG5B?=
 =?utf-8?B?U1I3T1VqeDNQRGlpa3dWc1J2bUZJODVGOGQxTFZGKzNScXREKzVpS3FXd0Nm?=
 =?utf-8?B?QVJyUGdlTGFXY1JvOVVYdjdvc1ltLzFoRU1SUCtlSTRJRmhVUDA3ZS8zUDhL?=
 =?utf-8?B?RldOQXhWQzU3bjNYRmNnOHVsS0l0NzJKNHFlb3liTzJhR0F0ZERIWkRUekpr?=
 =?utf-8?B?YlE1dnVHSlBnWWRWMGU2ZFNEcGU0ODI1cEZKS3NoVE9LVzRGdEVGV1RlUjFo?=
 =?utf-8?B?S2YvTXRpa1VzQUw3ejl4Tm9NNkdzOEpHZy8zYVpJWW1TQkNkZlAxemNFeUJB?=
 =?utf-8?B?SExqMkxLL2M4R3FzRFd0ekRhTkN2bWowQ1VNeGZZNHFSaUlWTG1WVzA0bXNU?=
 =?utf-8?B?VGJVdUN3Z1V0RXUwV1ZlWmlZU083OElCMmFXS1lOd0lXd2RSL2pVNThFdnlZ?=
 =?utf-8?B?bXRDcVJobXdOTGVvY1hTOGZ2cXAzb2RwZ1FkYWlUVSswdXlJS2VMUVdRUWoz?=
 =?utf-8?B?d010QVZTT013Rkx6YnlpeWY1enJvZGhlV2lXRlkvYldyZUJ6dk1jS21BbUZo?=
 =?utf-8?B?eHg3a29PcmJQbWZoN0RwUXRlblpTMktFZzl4M2d2VUp4dGxXUVltcjRSQmp2?=
 =?utf-8?B?NVZZMHp1V202dVFFK1QwMFQ4Sy9adXdOcE4rVmU3ejFhbDM3alpseGxPb0xy?=
 =?utf-8?B?T1RkMHBRakhvTUFrZFJFc1l0Zzh4ay92THh0RnMwSlZyRzVSeWZBbGRmQzA5?=
 =?utf-8?B?a0Fzbmp4ZWZkays4N0tmQXFkWEhpNnM2cTZBaEpSYTZuSjFmRjAxUXZraWhJ?=
 =?utf-8?B?ZHVrVE9SaTJnMUh6QjQvVGFXZHpFMURuWUdvMi96bEhQQk5iNkhiSUhVUGxj?=
 =?utf-8?B?LzZNam1RcTVqdXl4RTlNdU9JaE1kRjg4cXYrZlA5NEtwS0V6eFJOcDNpQzZF?=
 =?utf-8?B?RTdvMWRadngzYzVQNldmd0UrZlFJV0l2RkRWQ1RHOFVYU1RxZEt5TkRyeE9B?=
 =?utf-8?B?SlFFQXN1WGVtekV5SXRVRE85RXRlWGF0VTREWk9QbnNkdjF1cU1vVEQxeU14?=
 =?utf-8?B?elp0alhjK2tMV2R3NVEvS21iU2EyQkczL0x2SnNONys5Q2ZSV2h0MUhIR3dV?=
 =?utf-8?B?cUpYS0xEeVNlaTRtbUpXcU4rbjRvUmliMjFnUmJoVkFmWUhoclhwd2V0ZzJ0?=
 =?utf-8?B?VllzRWJpdXVNeXhrVlE2WkZrandQbElKR2JmUzBBR1krN0JDdUg2VUEwQ1Rz?=
 =?utf-8?B?SS90cW5COXBsbGhkT3FVald3QWxSOUJ6OExrb3BlTXF5OU96ZzUxZngzclZ6?=
 =?utf-8?B?Nmh3NjVqZU51aUpkQ3FOMXkxeFNEVk9jdk1xclg1OFdkNnRCZGpwbVJCQS9Z?=
 =?utf-8?B?R0IrNVJZRkY0eXBlbnBkTERVNDZySE1wTHNGYVAwcXpISTloU0xKZVFzY3Yw?=
 =?utf-8?B?NlNmZmNWTXhrZVNVREIrZStUVThyaXFmNW42RDFpck14MjRjRkNnZTlPREhX?=
 =?utf-8?B?NFZiNnlTSkVPelNnZlNMTCtFRXZzcis1RE9pNkVTemExSDE3c3o4a0VMSEw2?=
 =?utf-8?B?N21icEpsSWFOQlFCU3o3QUhjbFdWV3FFdm1JeHhXQnVDR2pJZUU3OXZUMlY4?=
 =?utf-8?B?VzJCVmlYVkxhOTdia3N3YllWQlBYTWRlR1NtQWc3OWRnUW1UMkZRcHhsaUJm?=
 =?utf-8?B?TE9WQTdVVXdpOVdPekhjdDI2c0Z4eHd3Ynd3OE5PZWFDTWxvMTJtWGtUQXhE?=
 =?utf-8?B?MXM0RlBuVVd4Q3pUQ2toUFJNbkdJQjNFUWptL0FoMjF3WGs0em1MdlJNWnRY?=
 =?utf-8?B?eGNMR2VXNE1tbmtjcDU4NEZZMitmb2lXQXhYSUFjb2xVU3UvaktMcVBLQlkx?=
 =?utf-8?B?UjRJUHJWb0ljd2NQQ2xBWTd5S1VpRERHMHZNanVwUTB5eStkRW15NHNTU1F0?=
 =?utf-8?Q?BNPFtQoTS0Zm2U9OqLSGyHf45?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd1797-9bb4-4bc1-3f68-08dcd969a808
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 11:44:59.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2E2uyiNHUo1imk/FqGl/gAaZFjcSamgWezzKEnBDhhwLj4vyzpATmjyRzdIVh77NGZKrFATcJw5Cd79hRq8p7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com

PiBGcm9tOiBUb255IFcgV2FuZy1vYyA8VG9ueVdXYW5nLW9jQHpoYW94aW4uY29tPg0KPiBbLi4u
XQ0KPiA+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS96aGFveGluLmMNCj4gPj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uvemhhb3hpbi5jDQo+ID4+IEBAIC02MywzICs2Mywy
MSBAQCB2b2lkIG1jZV96aGFveGluX2ZlYXR1cmVfY2xlYXIoc3RydWN0IGNwdWluZm9feDg2DQo+
ID4+ICpjKSB7DQo+ID4+ICAgICAgICBpbnRlbF9jbGVhcl9sbWNlKCk7DQo+ID4+ICAgfQ0KPiA+
PiArDQo+ID4+ICt2b2lkIG1jZV96aGFveGluX2hhbmRsZV9zdG9ybShpbnQgYmFuaywgYm9vbCBv
bikgew0KPiA+PiArICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+PiArICAgICB1NjQgdmFs
Ow0KPiA+PiArDQo+ID4+ICsgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmY21jaV9kaXNjb3Zl
cl9sb2NrLCBmbGFncyk7DQo+ID4+ICsgICAgIHJkbXNybChNU1JfSUEzMl9NQ3hfQ1RMMihiYW5r
KSwgdmFsKTsNCj4gPj4gKyAgICAgaWYgKG9uKSB7DQo+ID4+ICsgICAgICAgICAgICAgdmFsICY9
IH4oTUNJX0NUTDJfQ01DSV9FTiB8DQo+ID4+IE1DSV9DVEwyX0NNQ0lfVEhSRVNIT0xEX01BU0sp
Ow0KPiA+PiArICAgICAgICAgICAgIHZhbCB8PSBDTUNJX1NUT1JNX1RIUkVTSE9MRDsNCj4gPj4g
KyAgICAgfSBlbHNlIHsNCj4gPj4gKyAgICAgICAgICAgICB2YWwgJj0gfk1DSV9DVEwyX0NNQ0lf
VEhSRVNIT0xEX01BU0s7DQo+ID4+ICsgICAgICAgICAgICAgdmFsIHw9IChNQ0lfQ1RMMl9DTUNJ
X0VOIHwgY21jaV90aHJlc2hvbGRbYmFua10pOw0KPiA+PiArICAgICB9DQo+ID4+ICsgICAgIHdy
bXNybChNU1JfSUEzMl9NQ3hfQ1RMMihiYW5rKSwgdmFsKTsNCj4gPj4gKyAgICAgcmF3X3NwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmNtY2lfZGlzY292ZXJfbG9jaywgZmxhZ3MpOyB9DQo+ID4NCj4g
PiBBcmUgdGhlcmUgYW55IHJlYXNvbnMgb3IgY29tbWVudHMgd2h5IGl0IG5lZWRzIHRvIGRpc2Fi
bGUvZW5hYmxlIHRoZQ0KPiA+IENNQ0kgaW50ZXJydXB0IGhlcmUgZHVyaW5nIGEgQ01DSSBzdG9y
bSBvbi9vZmY/IElmIG5vdCwgdGhlbiByZXVzZQ0KPiA+IG1jZV9pbnRlbF9oYW5kbGVfc3Rvcm0o
KSB0byBhdm9pZCBkdXBsaWNhdGluZyB0aGUgY29kZS4NCj4gPg0KPiANCj4gQXMgZXhwbGFpbmVk
IGluIGFub3RoZXIgZW1haWwuDQo+IFRoZSByZWFzb24gaXMgYWN0dWFsbHkgbWVudGlvbmVkIGlu
IHRoZSBjb3ZlciBsZXR0ZXI6ICJiZWNhdXNlIFpoYW94aW4ncyBVQ1INCj4gZXJyb3IgaXMgbm90
IHJlcG9ydGVkIHRocm91Z2ggQ01DSSIsIGFuZCB3ZSB3YW50IHRvIGRpc2FibGUgQ01DSSBpbnRl
cnJ1cHQNCj4gd2hlbiBDTUNJIHN0b3JtIGhhcHBlbmVkLg0KDQpTbywgdGhpcyBpcyBqdXN0IHlv
dSB3YW50IHRvIGRpc2FibGUgQ01DSSB3aGVuIGEgQ01DSSBzdG9ybSBoYXBwZW5zLiANClRoaXMg
ZG9lc24ndCBleHBsYWluIG11Y2ggdG8gbWUuDQpXaGF0J3MgdGhlIHByb2JsZW0gaWYgbm90IGRp
c2FibGUgQ01DSSB3aGVuIGEgQ01DSSBzdG9ybSBoYXBwZW5zPw0KDQo=

