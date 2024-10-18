Return-Path: <linux-edac+bounces-2137-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD19A32D4
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 04:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74791F243F0
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356E14A088;
	Fri, 18 Oct 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POCZ5xtM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EB39FD9;
	Fri, 18 Oct 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218282; cv=fail; b=H3sewRQNS7gNa9IC60QrIeZN3Hvct70MRYYqEysUv7QBCcT3cktcvhAnjYKhKE0e2Sjcx5/8uiLogHz/cBgbK35hGG2wYOM3O49jA+fVRyPz/5ZtVhJPIUaOxOZOL09r/yuiv17QJKl4mCnzwzODQHpRzaAvXjUh84C/7r3/xho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218282; c=relaxed/simple;
	bh=lYo9ouEQQgLvI7CCcidJX3yZeccphjx+T/93VGdquPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXy3RuIDUbYHHxDwy/oARa2X+52oWDIMurHUSJmmGlnoYgXNmVn5On9ARHI4iYXmfvkjws1ahUJeh+G8BeQXkmStm8mjAZJgthuR9Auplb9ZE/SeDSGOUOfpYysdPTIyL25NFmNGKO02YVzu5hnMwdBh2zZVZI1v50vZMt5JrYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POCZ5xtM; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218282; x=1760754282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lYo9ouEQQgLvI7CCcidJX3yZeccphjx+T/93VGdquPE=;
  b=POCZ5xtMX8/PwvlPODpcBdEbwEaJGasKXAC11jT32J8oMFeWhw9CFcC4
   4PMTOiPHV4GQKLhuksBZg9HjISntaH46cMvtcomVP7HgWIZITb7Q+VGaD
   ZqppPngeGE6q3u7RII8tollbQZflzHngzVf8sxD+cEDToY92YoWjWYzRI
   l0a+nvtpaC4+aRGx3PIhOkBsv6EmUzizdMSvmLXX/hrWnxVnY1Edx+cmW
   zapklx/TZpZaUp9xvTzMO0UX/qy+xC3c+chEkm+ZNTXmP76t61xSU91Q7
   EIBMSvvBSruq3JawNn7SXvn4CBE6NOfV0l+aWJ6E+cuspl/wDlnj7ffD0
   Q==;
X-CSE-ConnectionGUID: ytCg6mXWThW8TtFHbXCvCg==
X-CSE-MsgGUID: xL81Nc5eTamdX0P/kqczYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28619311"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28619311"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:24:41 -0700
X-CSE-ConnectionGUID: JnDdVmw/QI6CawAFeoO2dQ==
X-CSE-MsgGUID: 1QTaAy9GQxKFCXbfHECxKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82690628"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 19:24:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:24:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 19:24:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 19:24:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 19:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk/mQGHCvffD2YRYJVSPuVl9tvvQu9z+x5DcIEjeeylxaMun4I/8cOUQ+mA7NgktFVcGYOy4wPQC6CH3ExLDtSqIxRo4pRMALsRnYiQmoBKdwFi+Mw4/kHOTlpu9ZJaivLhm6hgwrdFPgDvFcNotGLNVfOW1MHrVzmzBqeeqtXGK69PjMg1LWBu1vCPXN/TiVtzkI/5aTMLxWxkyURmcSp+g/Ncgfer7pvgVYlxnIFec69FyQ2j3Ak7TZ6jV6BaZQVoQN3utlLs5NoIWzb4hiay2F0JSXEvBgdA+JxxVuysOxhmJD1lntad4zyRFYfUD98wNHMxxX9nnzS8kvTVIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYo9ouEQQgLvI7CCcidJX3yZeccphjx+T/93VGdquPE=;
 b=Gc/dhk+J1NF7mdx62XLVJxMm4gnzU7BkBMEsA5la7PfnGYUk7BmUeP+dfLUM1JGVnq8n0mRge3jcnOboyQXjwXB6j5zR2O9YP24nDZpidWhvbqPLDnMc3M0F+S+aZmV4Me+PoKHe5pAjCFo4qNQpWTst4qfAZc78kDVXKMHndRAz8br5yGRwGFMNldX6cgQvBfYJCKT2lWaRqhPaKZTE2nKkxmEdInj6NpNQr5MXohNWQE58VZqG+fbKLzEYoESiu3M+f4J1A6z90hRU9BZDvYxhFol/3tJfRdKGRRu1kRF6ONIhPE1nCLK1nKeLTP+v0o55gs/xZIS9oai2v6iK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.19; Fri, 18 Oct 2024 02:24:37 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 02:24:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>, "Avadhut
 Naik" <avadhut.naik@amd.com>
Subject: RE: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHbH5ZrAuU8UmdKFkOX3yhViLnZqrKKhOjAgAD4w4CAAEn+AA==
Date: Fri, 18 Oct 2024 02:24:37 +0000
Message-ID: <CY8PR11MB71346E0906C0540C998730DD89402@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-4-avadhut.naik@amd.com>
 <CY8PR11MB7134178B954B4DFFF6AEF81689472@CY8PR11MB7134.namprd11.prod.outlook.com>
 <8c71d83b-4dd2-4411-aac2-81284bf3a9df@amd.com>
In-Reply-To: <8c71d83b-4dd2-4411-aac2-81284bf3a9df@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB6043:EE_
x-ms-office365-filtering-correlation-id: cc423461-355c-4d2f-657e-08dcef1c035a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SnNuZDFzVmlvaEk1OTVEcDUwUkxFNkhrdFZsQjJPRS9PRkRyalA4bzZCeHkw?=
 =?utf-8?B?UHVRbjc3ajRtWVFXUTUzSWhuMEFYWE1YeEUwTUNKcDNaYXByTUVuWHk3K2g0?=
 =?utf-8?B?eHBuVndmcC9vMzdGWm1HU1lDaGlYREhkMkZJaTZKUG5ObUFwcWtXMGtqSWQ5?=
 =?utf-8?B?T2RQQmF2dzZJQlJxYUVDLzgwUVMwNTFycGFPcmo5Tk9qL0dSeXFnREp5ZHJx?=
 =?utf-8?B?dEZhMTF1eWV4NW9ZdUoyVG9Td0hOVUtQRWh2alZ0NnkyTmZaQUZmQWY4ODJx?=
 =?utf-8?B?SmpNenFndkxlV0pxNGZROXg0Ykc5WlVSZnVmcXYrdkZOL1hrVXlobW5WdjR3?=
 =?utf-8?B?cDh4VHZ2enJZM2h6RGxUWDhwbmQ2OHgxUjdicGgwUUxITnQ3UE91REZsMlY0?=
 =?utf-8?B?TXhodEpZdklia21Lb2JOU0NFTEI2NWhFMjVVcHl3UmxhSTFqM0pEQUM1Ukt1?=
 =?utf-8?B?b3ZkdC9TQVJGV1ZIQ3FEbzZvOHg3d0FHcnNtTG1rY2E2eVJLdDE3WlVIaHpv?=
 =?utf-8?B?cnNTUUU5UWtmME90VkdaOTFDam1hbkd2S3J1YVNkc09ZUytEYmVSdTB0Tzlv?=
 =?utf-8?B?S3Y5M2NZWjcrcFRaeTlkNjBBRGdOL2pkdG1KcDRlRHpodDgyV1FCOW9zY3dB?=
 =?utf-8?B?OUxvMDdjajQxMXFjdWlhQUc1NUdhNlliZllYeVJxT085eUtwOGdJRGtZTDYz?=
 =?utf-8?B?aC94eHlqQkhtRU1sU0VxL0krTm5wRDR6WTY4SlNiRmxpeDFXbFovNC9mVjQ4?=
 =?utf-8?B?ekdjcVp2VTBGUlN1T01qdGM5dHpaamo5RkdwZUo2dTQwRHhsTG0rcHpkVndV?=
 =?utf-8?B?NS9ibjNUd090VFExb1dUVEd4NEQ4ZEdnSi9palE4dG1VVUllbVFmNzhGcE1r?=
 =?utf-8?B?Q2w3VjVERkRWMEVDcjZDbFIyWE8vbGdNQUhwcW9LOGkyUUxITi9PMjdNNmNh?=
 =?utf-8?B?K21OWXMrZE1jZ3lGTE4ybjhoWlVTSUZkVlNDcWlPeVNTU0xXYXlVL1ltSk9w?=
 =?utf-8?B?anZtTUxHZUZRQ1BTTTVSeWQvS3Jid3VscUN0TzFqYWZGZ0FsODYwSG16NjhW?=
 =?utf-8?B?OUpwSVZtcFdXT0FUMW14V3V0R2ZKZzRRVTdEN3Y3UHNEcGxjekZla1oweW1j?=
 =?utf-8?B?MlFpQU1GOWRHVERuRTFreFZGZ3Bid0FobTRxcjZDR2phVWsrcnpDc1BsalN0?=
 =?utf-8?B?QVlTL1NYUjYxNFpuUzB6YkRPR3BmT1pVTEllR1F0RUxPNkUrVDV2OHh5WVVv?=
 =?utf-8?B?WGpmV2VaNGJxTzVMRFBOamlabm5XQXhqWjNWWk5CbmQyc0tEc2R6eC9CU0lo?=
 =?utf-8?B?dGVnbllKVXk1UVFPRkptc0I2YW1GQlFWd0Rtd0w5QnpoYUNQa1c4NktRb3li?=
 =?utf-8?B?QTFjNTUzMWJ1N0piTVgwb0VOM1piNEVFdUtMekFUaXlOUFl5VHZ0VGRKMHN4?=
 =?utf-8?B?V1lhYUplNkJ2ODdhTHRpdGFsallyUUV6cFVOM1lyNlgwV0FMYTVpRkgyMUpj?=
 =?utf-8?B?dWczRmhqRDhpR0NMRUhnMGI5T0plUGordnE1Vk5KVVk3QTh3ZExiTWMyWExp?=
 =?utf-8?B?V2VyMkhTbCtkZE51b25EanZRRjd2MFE0L0NBWjkyQXFNVDdwSEtVRngwRDhi?=
 =?utf-8?B?RWdvNGducGtiUzRJZ3huQlVZYTRpY2huenM0NUpWcld1c1RWRjFQb1hGOXNE?=
 =?utf-8?B?aUUrWlNZQWNxRWZpUng3QnhiTXFYQ0VRU0Q3TTZ0WXc5NEtnTnhLVEpHVHFj?=
 =?utf-8?B?c1NraTJvQVlkNXpSSzZOdXVPZjN6MDJHbjhKZ2h1bFQ5RU1ZUml0ekJQNU9D?=
 =?utf-8?Q?LhUF0rKn0yVMtYQM3MPBROjYQ8PP4Dt8auQak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzBPVEhSeVRTaWx3Yjl2ck02SjlHSCsycUFSNE9IUVlGdlpCWWFIazkrbkNw?=
 =?utf-8?B?VFdCalVZcVQ4Q2VheHptMG1EUmJiaHAxVDlobWFXVlVIc1JhRHVNRFkzejhr?=
 =?utf-8?B?M1piTCtSNGQvWGFVdFpteG1zTUxqeUxSNElJVFJmaSsvSCswazNLTWNndHcy?=
 =?utf-8?B?eFkwSVNjK2NUNmFBTW1TNFo3cTdJZnVjdGNJMXNSYXUxRUNtb05jU2NkdS9u?=
 =?utf-8?B?WGh2cDVRK3RaYmkxK3NJY29iL3JqZXh5RkUvMTBrS2k5eGxEUE5TVjRsMnRS?=
 =?utf-8?B?bjc3VVJIb3hkNUIzbHdlbEtkT1NYL213OUlUZkliNldtRG0ySUF1ZWd3dHlz?=
 =?utf-8?B?N3M5cXMyRHI0R29ucS9WdGh2VjAzb0FzZDlONXlGS0dOQ1FzVEk0TzEzSXFY?=
 =?utf-8?B?VU9Ra1BpT1NoeFVYeFBlL1dDcWU5TjNOeEtMYmFsM3JqUjZVajdUTURaeG94?=
 =?utf-8?B?RnlDVlUwZUZBSGpWdjg5c2RpUFJXdkVIMkFpZFRhOGZjV1UwZm5vNldBUWtq?=
 =?utf-8?B?TlRTNjNRbUkzM3ExaHdUb3VOMG5xM2tqd2hWMVJ4aTI5WDJDVG5WcDc5a0lI?=
 =?utf-8?B?cktGVXk1MEhlb2ZnZVJ3MEhLTCtkWjdpUkdCNCt0TzIyVnBteFVtN2F0YXJI?=
 =?utf-8?B?WkVJaDNQdXdkbjVNWEk3YXpKWUJZNTZJZTdMYko1WHZGREVpNjlNRFBCL3VV?=
 =?utf-8?B?NFpwSlZxVUtDQy82ZUZEVENxa1lnVTdSSnlJb1ZubHRvbmZ6VDUxRmF5d0RJ?=
 =?utf-8?B?bm1CaEtVd1c5dEtxYUIzd3RKSE1PZGU5N21MaExxbnQyZm1IU3NpQUtnV0hT?=
 =?utf-8?B?OWJZM2tYL1dIaDNRN2FVd1pFamtKNTlWTGRvN3lPNzdPb0ZsWkpXZWtyNDZS?=
 =?utf-8?B?aUxhWm9mR0Vmb3R1RmFqckFqdkt1bEljUGp1V05KSTM1LzFGWHp6dk5LRDNE?=
 =?utf-8?B?Nm10OFJnamw1c0Z5aFhmSUNqRUJHMmU2NHFsVEdjQUVWOTVLTlpCOUZyWFBN?=
 =?utf-8?B?N0R5Y3lUeng0NHZMb1UvTStYQ1NBZVBlOERwazNmbEUvb0ZlRzdHUGlGM3dQ?=
 =?utf-8?B?UUQ1aWhqaDhISGZaeUR1RU9GSVg4dTZnWGNjTUlDVW1mdnRXdkw5enpydFd6?=
 =?utf-8?B?SjdpdlhKV21tdXRoNzlzNFJ0Q3d3R05ob2wxTUZud1dabjBlelBPbDFRYnJr?=
 =?utf-8?B?eCtGcXlDbUxadTNMaEFtQTVka2hMTHBjRjVhOWxqYXJkK29SUUZaYU9GNXVh?=
 =?utf-8?B?R1RLRXlSdVFQeWRlS0NjaXo2R3h2ZXMxODM2Wm5iWWFjZ0FPeUlxWExrT1Vq?=
 =?utf-8?B?UmdpODNPWW5IMzNjNkpZOVBzZ0NlVkJSblRnOWJzbFcrMHVTd1V3aGhDT2Uz?=
 =?utf-8?B?Ulc4aVROQXVyMmZvcTE1TWprNDRvaktmWThKcjdMOE9JeGlFU3gxU0ZhUGtB?=
 =?utf-8?B?Qzl2Y3gralpxOXdraTJBZEw2bkJYTFhjUTlib2t3Qk9yQmNPaHExVEo5aFk3?=
 =?utf-8?B?OEZoOU5GQ1VjSGNiMDlsNm5uc3grWC80anErRzFEYmx2UTdQNWdDVlN5N0ZP?=
 =?utf-8?B?a0hFeEtwQTRZTmhGN1JjWFUrbnNNS0cyUjY4bTYyMTBlekVpajhxY0QvOFUw?=
 =?utf-8?B?M0N6NzJQN2xFTnZ2eHd5YndtR1J2MXJWRWRsU1BoU1NjREduSkd5d29vaGRj?=
 =?utf-8?B?akE0MThWVHU4cHBmUzZQVDQxbXJodUlEV1hMeHlDTXRTMWpoa2pUWHVsRWkr?=
 =?utf-8?B?Q25TYkYvQW1kTGVMODBudi9CN1hJZ2V1VVJmeFI3bGU3cFQvdjE0MTQ5Tysx?=
 =?utf-8?B?S0dRbDQ2bEFFN0x4a1FqZHU2amRGMmEveDI1bElmbzZudFhxeGUwZnJCTlYw?=
 =?utf-8?B?YkdVT0t5b21zNDM1WGpQMkxIdk1OdWE5SmpOTHFzc1dwTUVkdGdEbHVlVzhC?=
 =?utf-8?B?OE5yV3lVb3ZpUnJnVjM4UmN1amNORjRuTXl2YzdPK1FwQlh5bDVEZlV6RFBq?=
 =?utf-8?B?cWtISk5LcGhUcFhIdHprdEgwbTVZb0FhbFVTWExZOGEzdHlHRUllMUcwQTc3?=
 =?utf-8?B?YU9Uajd2R2RUNlJ1aElVL2ZsRHBxOTdtdG5iWStDNmlTK0FFZEdJSStuVDdn?=
 =?utf-8?Q?zC7/YWQ8E4EOk04VO7i26GEpm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc423461-355c-4d2f-657e-08dcef1c035a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 02:24:37.3918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPdDhDRhyDiDZpGLRYFrOKVozNkBK5iKZkDBP3tDhN2QZxcnlor0+FJ4JjH5svmoi+DPZ2bWgdJvyocCigwKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com

PiBGcm9tOiBOYWlrLCBBdmFkaHV0IDxhdmFkbmFpa0BhbWQuY29tPg0KPiBbLi4uXQ0KPiA+ICAg
ICBfX3ByaW50X2R5bmFtaWNfYXJyYXkodl9kYXRhLCBzaXplb2YodTgpKSkNCj4gPg0KPiA+IC1R
aXV4dQ0KPiA+DQo+IElJVUMsIHRoZSBzZWNvbmQgcGFyYW1ldGVyIGFib3ZlIGRldGVybWluZXMg
aG93IHRoZSBkeW5hbWljIGFycmF5IGlzDQo+IHBhcnNlZCBhbmQgbG9nZ2VkLiBUaGUgdmFsdWUg
b2YgOCBtZWFucyB0aGF0IHRoZSBhcnJheSB3aWxsIGJlIHRyYXZlcnNlZCB3aXRoDQo+IGEgdTY0
IHBvaW50ZXIgaS5lLiBkYXRhIHdpdGhpbiB0aGUgYXJyYXkgd2lsbCBiZSBsb2dnZWQgYnkgdGhl
IHRyYWNlcG9pbnQgaW4NCj4gY2h1bmtzIG9mIDggYnl0ZXMuIFNvbWV0aGluZyBsaWtlIGJlbG93
Og0KPiANCj4gdmVuZG9yIGRhdGE6IHsweDNhNzI2Zjc0NjE2MzZmNGMsMHgzMDQzNGQzMDUwMjAs
MHgyNzAwMDAwM2ZkfQ0KPiANCj4gVGhpcyBzZWVtcyBjb252ZW5pZW50IHNpbmNlLCBBRkFJSywg
TUNBIHJlZ2lzdGVycyBvbiB4ODYtNjQgYXJlIG9mIDggYnl0ZXMuDQoNClNvLCB0aGlzIGlzIGJh
c2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQgYWxsIHZlbmRvciBkYXRhIGZpZWxkcyBhcmUgb2Yg
dGhlIHU2NCB0eXBlLCB3aGljaCBtYXkgDQpOT1QgYmUgdHJ1ZSBmb3Igb3RoZXIgeDg2IHZlbmRv
cnMgaW4gdGhlIGZ1dHVyZS4gSW4gY2FzZSB0aGVyZSBpcyBzb21lIG5vbi11NjQgdmVuZG9yIGRh
dGEgaW4gDQp0aGUgZnV0dXJlLCB0aGUgcGFyc2VyIHdvdWxkIG5lZWQgdG8gYnJlYWsgdGhlIHU2
NCB0cmFjaW5nIGRhdGEgaW50byB1OCBkYXRhIGFuZCB0aGVuIGNvbXBvc2l0ZSANCnRoZSBzcGxp
dCB1OCBkYXRhIGludG8gb3RoZXIgdHlwZXMgbGlrZSB1MTYgb3IgdTMyLCB3aGljaCBzZWVtcyBl
dmVuIGluY29udmVuaWVudC4NCg0KSU1ITzogUHJpbnRpbmcgdGhlIHU4IHRyYWNpbmcgZGF0YSBh
bmQgbGVhdmluZyB0aGUgdmVuZG9yLXNwZWNpZmljIHRvb2wgdG8gcGFyc2UgdGhlIHU4IGRhdGEg
aXMgYQ0KbW9yZSBmbGV4aWJsZSBhbmQgYmFsYW5jZWQgYXBwcm9hY2guDQoNCk1heWJlIEJvcmlz
IGFuZCBUb255IGNvdWxkIHByb3ZpZGUgbW9yZSBjb21tZW50cyBoZXJlLg0KDQo+IElmIHdlIHVz
ZSBzaXplb2YodTgpICh3aGljaCBlcXVhdGVzIHRvIDEpIGFib3ZlLCB0aGVuIHU4IHBvaW50ZXIg
d2lsbCBiZSB1c2VkDQo+IGZvciB0cmF2ZXJzaW5nIHRoZSBkeW5hbWljIGFycmF5IGFuZCBlYWNo
IGJ5dGUgd2l0aGluIHRoZSByZWdpc3RlcnMgd2lsbCBiZQ0KPiBsb2dnZWQgaW5kaXZpZHVhbGx5
Lg0KPiBTb21ldGhpbmcgbGlrZSBiZWxvdy4NCj4gDQo+IHZlbmRvciBkYXRhOg0KPiB7MHg0Yyww
eDZmLDB4NjMsMHg2MSwweDc0LDB4NmYsMHg3MiwweDNhLDB4MjAsMHg1MCwweDMwLDB4NGQsMHg0
MywweDMwLDB4MCwNCj4gMHgwLDB4ZmQsMHgzLDB4MCwweDAsMHgyNywweDAsMHgwLDB4MH0NCj4g
Q29tYmluZWQgd2l0aCBlbmRpYW5uZXNzIG9mIHRoZSBwcm9jZXNzb3IsIHRoaXMgc2VlbXMgc29t
ZXdoYXQNCj4gaW5jb252ZW5pZW50IHRvIGRlY2lwaGVyLiBXb3VsZCB5b3UgYWdyZWU/DQoNCng4
NiBpcyBpbiBsaXR0bGUtZW5kaWFuLCB3aGljaCBpcyBjb25zaXN0ZW50IGFjcm9zcyBhbGwgeDg2
IHByb2Nlc3NvcnMuIA0KRW5kaWFubmVzcyBzaG91bGQgbm90IHBvc2UgYW55IGluY29udmVuaWVu
Y2UuDQoNClRoYW5rcyENCi1RaXV4dQ0K

