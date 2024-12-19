Return-Path: <linux-edac+bounces-2747-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EAF9F7DDC
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2024 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1105165A86
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFF221447;
	Thu, 19 Dec 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDUnch4L"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA44441C64;
	Thu, 19 Dec 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621629; cv=fail; b=aQETc6RXritfCrJlh8wzpv3OtOXqyv0aC6wcPD3rjS42oupO4tSCIgnaTWGvHZbddGEccgnfCBmaPYOrWgZisRqXtbdnvEYhhokBUkXNeb5NrUJPuoMmQMePccweKwU9gxE2w4O7LkrHuU78gOuXHkhlS5QWZcQaUiBi6KmXn/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621629; c=relaxed/simple;
	bh=n2laAYIK+m2S53IxIt1AjCEJ1TcVo1SXRUNGNx0i/vQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=faC/gZBUKCEPsJQ4WszTHYinD/vBH8EFHzXkQiCelIUCPou0Sh1Ex1c3O86nF3rhLVKx3EKuMiKVEdeMb0JIEy7BloktXJysVdSt3LWDz9qeiaV7Q9tFQXZJh6+dBTQ5apM08Z3JSyIpUyLtuHsjb2FeeiW+lbM1264vN5V14lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDUnch4L; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734621628; x=1766157628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n2laAYIK+m2S53IxIt1AjCEJ1TcVo1SXRUNGNx0i/vQ=;
  b=SDUnch4Leo1x1o4sGkOBjtBFkkOzpOk9TghODD8RINK2JgqouEIaa9k8
   NDk7ur1lS/vS1F2qx+nqVaSqAoIED6aOXj9k6EF0zvyOiTd+u6DHF4ZGG
   zr/VCzUoB4pT+4uwp2dJzZW9UM6bXXBbYBv21d4U6VrWl+3/9+wY3AUWW
   atGFcNvyoXYdY8MO/K1SWHjs6tbNI/jJjOD2qS6/rHDXk+iNNOlU/PaGD
   +ekLvYj+WJoC2H+MDxERDERb+U91pyJDH1vKITx63kTMyiwDMht2o8aGC
   u1vdB4ctBCgmRNKc703xfjX55Fc2pJ7adljQfCQoIsut4gFjZHyyd74U2
   g==;
X-CSE-ConnectionGUID: TEiHG8zDQ/2kdbyoO/Pj+Q==
X-CSE-MsgGUID: YR/OoIrTQz+fys8sH40yHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34458101"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="34458101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:20:27 -0800
X-CSE-ConnectionGUID: AHINGJJKTSegwoYXy3fYEg==
X-CSE-MsgGUID: zeqBosDeTeW/ea0X+dfVhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99048712"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 07:20:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 07:20:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 07:20:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 07:20:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLyzYKZvHIqXv+lXLHmnvbfTySEmuv3/8gpviGpf/OfB76sWk6OXJ6TKM8sao/yz4oLALPihtZ58hZbWYY8CSc+cZHhTeM9aRhPAmbL7tg5MvOpHAY+gfSWHhogq8tEo3EQzIiGT6C2cyuYGAhSA2TDCSB0fQvfulRYowp++aa+DVficBKJaaDk7LTxZirYWJ9C7i1v/dk3rACpPkUyW+MK3YXM0iofddSsJZMBUcjtYttIzEl47Pbv1wXps386aYsx1fLKcdeoRFZ6ZYuyh8Kldv+kHDcU1qE1ndbB6iZlwFuD4dtSGrrYvPKOD90r4VRM4gVTs0BUrbIwOmJGx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2laAYIK+m2S53IxIt1AjCEJ1TcVo1SXRUNGNx0i/vQ=;
 b=jOB/HdQ2k9nyr0zPqhhxmremRHLrdyJLNaUYhumNTUSQ1Tsaq//sWegu26ffRFjS1qvBVdggEI5CydjNNopY5/8xlR+0U0NxDkPYE28/3gVJCpdiGkxIpFmK/pJYiNu/XHdA/+RsfFmgZileroKwAtvHv9hCAQog6c/CB9fONlRaKEtJoM0wHD3YXuflH5oQcDWAeSp8lpLBqbj3ClY5GDznX7voFicgv4XZfhFjkhRm2ju6GvG3uO+/2Dm1bEVEfaLtXYUdr6ms7CtF+liqEY1A3+4cYDD+GijNLm77hMyR62xDhTvvwo3MYfs5299sf/HEDSiV+CXITYpE3l+tRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 15:19:40 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 15:19:39 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/7] x86/mce: Make several functions return bool
Thread-Topic: [PATCH v5 1/7] x86/mce: Make several functions return bool
Thread-Index: AQHbTJ6Tu2NgymooYk+zg3YcCjj40LLsJ3CAgAGRrMA=
Date: Thu, 19 Dec 2024 15:19:39 +0000
Message-ID: <CY8PR11MB71340C71D5493F8F05731DEC89062@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-2-qiuxu.zhuo@intel.com>
 <20241218152015.GA1155365@yaz-khff2.amd.com>
In-Reply-To: <20241218152015.GA1155365@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: 60584283-a9ab-4908-bb33-08dd20408e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tJfcRrkvYz52Hwa6yvAoF23pjstbgCoGJw26akLO6BD7YeylGLztLgINywiO?=
 =?us-ascii?Q?AZa0iShnNzn8aLGVQ+UhbBrJhoOVyo7ZcuRqljno0/JFfwog6XWR28IaA3Sn?=
 =?us-ascii?Q?UsqyREP839pclCPDzvn9lp455MrE2clSEWFjAypBtuwqKuBJSBTecJTlpBq/?=
 =?us-ascii?Q?l1sJq+Xji/dgNupTG2LV/kGRnZLHejEzuE0PtzycCbGI/IPBat9q4SpzWG6I?=
 =?us-ascii?Q?hybj1+0Bdr2sbrOS6wKYbeqE8gQnJZqUIw3NYCIE1FlcVd+sJ68pZ/cD2XX0?=
 =?us-ascii?Q?2/8k49wZvIyjDfVJSQ4tgBhuKk4TmnAgi5yTYTU6Qphmz3i7LS3Jc2AI5FW5?=
 =?us-ascii?Q?kk5tqauJg60WS8IDGuXW5Ey28M/xRQogxgh3Zse231vTFXBS1JK9DL3qhkyu?=
 =?us-ascii?Q?GyYomD/rFqG/TIoP2XjVrbWEQ/eNFXZVUDEXxLA4IXmnOoC8RGCH86lr7uqK?=
 =?us-ascii?Q?rCSWx++DAmeS/7kp2iZdbIJGY5uZvD+8U8aQAgdv9jhmJt2n0/3Ao4geMFJO?=
 =?us-ascii?Q?Y1/WsHTo0F5bqhwQviY5Hcd8KvLj8naTuhZIqH6nD0SpcFyvUSwSB01q/VVK?=
 =?us-ascii?Q?dwwi1bUuhon2Ut5XJJEUH7ONVaiB/BOvwXkWszeflcDuAkhG/L/pUgIpf+Qr?=
 =?us-ascii?Q?aSzF4GFPKn9pbguwALPm55sNPHKnxM9jmX6D3yc0DsBkhazpeezmkt8DAFDJ?=
 =?us-ascii?Q?pABclbSmxD7mUwAu0iLnJWQDFyKg0PhvU347ciieu+R2Ovo5fFCHTkvcJRZv?=
 =?us-ascii?Q?8JGYOXohetuM0QW32TRqUskd7qPXfOHFCKYoIwr5GXYmj/5vjr41n/TgHnOQ?=
 =?us-ascii?Q?eaZO4Oxu5jHl4/2zKJ2AuKnSZ3RvexOY8E+Ky75qCTlRIHBUhR5wbf7QjPmC?=
 =?us-ascii?Q?Eh6HNdaZYX502w9tT1Z14ADitEgrVE+CsXWQV/YNFeHK3pdYp1IZvO0W72FF?=
 =?us-ascii?Q?CF9RRTwAUJ/1vtjohn28DG4WW3l13yxrC2bWVWSYFjb/hfH1jWKTwEcqR7+H?=
 =?us-ascii?Q?Yf1b9zGjc0+6fuWy3Osws64tCj7BFsxB+ppnLfKPSSe6JdqtTOzRcm6XXDKi?=
 =?us-ascii?Q?yQphfLr0DGIQq9SR815uhm7Dr6sEbPxlPxNXSb1q9asFmsTdvvf9zT4KXvdS?=
 =?us-ascii?Q?zQrkZf5fihHHQ5mATSZ/XzWWeNdUss43pJiKJcew0VJ10Cv70xvcGPSim+sx?=
 =?us-ascii?Q?k8V9Lzcg60af3GX36e3XvU4RcA0k0d/xiY3OEyBxlys4QgJBGWFVgsBiXf4t?=
 =?us-ascii?Q?OjG2ustF0oufNldYnMRhSk5HTWoEKAETwKu82nDFyN4uHhMRYdP+fZXuV4ZO?=
 =?us-ascii?Q?XOBw5gAR6Zwbme4fwIfv1SFrCXu9JvaEA3oq+RCCBxVYxp76aL32NRJQDmBm?=
 =?us-ascii?Q?k7glK2uNY5pnzdz31rA5TfjHdhJPxD+h/mpry9nQOBbpgnjg0p03Mf1IgkOR?=
 =?us-ascii?Q?yUAuqiju8QsaL3Ys91Zyn0bq0eznHnoA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZhJyn4yTWga9B48AY2o+0+M2lX16bFzqJ0W6v96IyCHxp1PMRy8NEkJHOq2k?=
 =?us-ascii?Q?Yf1ulEkpXPy+qo9XixTWF9XhhGEluVw1Q4sj+vhPgrNOMm8KiKzkVcosDkJe?=
 =?us-ascii?Q?Sn2vO0A7zga4u+E+te9ietYJUyV0ckCW5FG9Hq2zRKAkB+yJ5WMEE3j5smTx?=
 =?us-ascii?Q?CLvz4cErnRimRppIYYhncrepy8xhuTg2PXE9ugy/TJm3YOL5DR+JUrG3CfKX?=
 =?us-ascii?Q?RE+p/5cQkIUItCZKvEi2nN6J/9iBjBHD7OMRXCsE6pUwEcr7+43FcH+Aqg0r?=
 =?us-ascii?Q?y4UpQc2KHx0M5BeI/1uROHGv4cYAOHYwGnJsQ3VuFBtNxT2ipkb88y87p5AK?=
 =?us-ascii?Q?F9vp4czsRScw5wJEuw4wUoqJF4edbkLbSCP7MClwNWSkLDzX2u3fJpkQeYTE?=
 =?us-ascii?Q?LGwOcVk+l0A1cBVec/c2njDXmSTh51TIY4pVUJW1XDTNS+Sj1q2vaufssOKh?=
 =?us-ascii?Q?mOhxIyR4h8Lh7OR8Fb762xQS8p8yiIOGYLKAWI3XO9zlPW45K48Y2jg+eNMB?=
 =?us-ascii?Q?MezMYZVi9Be3HUzHZCmTLCAXQpwaj41YL2mX2RFGd5HMAzSncKeZOhmyDol7?=
 =?us-ascii?Q?BNG15Kix0jqdxq5L7UWsV9wH9PMIz5IxRpHyNqnsCPDdOXsGbE3KGcVmWRGl?=
 =?us-ascii?Q?dxxvLug0CxGbgOkA138dbVMHYsdBchsNmqc7Vt6Rzw0ATK7VPrhtkQ4uTONp?=
 =?us-ascii?Q?/uGizb4v18KiIb8Ub6/78ZuO2ciw0zfHyzwLs+A2L+DUrMXdLtv0Q5xxQH/7?=
 =?us-ascii?Q?cBwlJL8i70sZSuqFpceEVrUZz5FQaPF4BeaqYz/bZm+8VOD7gw8yL+EMKbQW?=
 =?us-ascii?Q?DG2BknOmZWW8dje9QUYXVikINu43y3zOaY0N0qxPP3hB4nr95W6q/5NeXXIl?=
 =?us-ascii?Q?kOzBbUfp1HJ1a5YGYi/sYyZdQVKHuXSDzPYM3/ZjotIYs0Q0qXKoyehGmGWm?=
 =?us-ascii?Q?s/TuxZ4tu6YHNMh991QwaNOx3Vpsj9WoXFYV6LhfoLGn/kIh/B0IEm5dCfyu?=
 =?us-ascii?Q?v1vSB9jI8miV4z3unRe2oz9ru8vebR7u+YFi2U85yn1zV52Js332jTJ6178r?=
 =?us-ascii?Q?ug1Tx7MgaLuzUT7UeUOGCnd08H5qmVqb5B/4VzsfQQF8/euF6ygi5UYAXw95?=
 =?us-ascii?Q?T+nbN72utICop6klMBL25BIBoJBNSWNMo/A5H31qCxvT9OUik/LBLanvv5/h?=
 =?us-ascii?Q?cRqOX3L1Q/xngtuAMBa4C/T6VfQtMJ21smNmaT7u7r//UIfmyRsDZKQ3XAEm?=
 =?us-ascii?Q?ytbDz3CP2bLV803vcETd89Ix2aSS6xURI9UoLGeOJUx6oANhviF0+0nRF8sX?=
 =?us-ascii?Q?1qGHpIjQfDVlyWajDfH1nKhsGECjpubIMrJsyXUmdcMFFZATuAgi+19bid8I?=
 =?us-ascii?Q?41DLdwpbPEyOAxKyBwZM+fLAZn3PqzFtZ5lmueHzE1IP4+/aM102ER2gRmJ8?=
 =?us-ascii?Q?LPhWOCMDqXqOMUdOPh72xhslwnxiGsQ4y0FFb1Kfo70Xi5n2h3yJeN8Ephzs?=
 =?us-ascii?Q?kr7ljkWig261lxUpEv/c4+Le13jQo0voXlR8bRb8hllz56rZFlYn9d1nzJUj?=
 =?us-ascii?Q?+b6LHpd/8I7eAVU+V3z1m9TXrdNfeXJcj25wLT3t?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60584283-a9ab-4908-bb33-08dd20408e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 15:19:39.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJ6eagZWhDyZHnaivB0hcF3eDFdSgLFJUx/qsGtgkPen2CnGCDfa8HyjmI6HgX69GFys/NoJm2YcumF4y98hVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> Subject: Re: [PATCH v5 1/7] x86/mce: Make several functions return bool
> [...]
>=20
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Yazen,

Thanks for reviewing this patch series.=20

- Qiuxu

