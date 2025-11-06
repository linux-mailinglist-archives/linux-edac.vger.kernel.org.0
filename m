Return-Path: <linux-edac+bounces-5364-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208CC3B21D
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F8E4F1717
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3252DAFA7;
	Thu,  6 Nov 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6FJZmdI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199130CDB7;
	Thu,  6 Nov 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434463; cv=fail; b=P4TF9LR6qLjbb0Ep0CAeogiJbF1uCBhbutp2EAHeecdYgUqewP+PrKeqOVci4zPqsQDsyZAkE81U1KR0Mkvwn+bZIyuqWrAcm1J4Rk5x+blYD5xsdIrGYyjCYMRorRKpvHXI9LF4qUfRefe77O8lIiEBnMK7uZcVV8HjSD990Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434463; c=relaxed/simple;
	bh=ycjoU4qZZjVUqSKJvRIjRsx462xz+TdwcITr2Z+pQGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hvrri/x9+91pRwnrTPYP8fjBjjWxmXA1QIKsFkQ6ee9WFoHdXTgYhxkDBGdRB0NWwb8N3IV6c3L+U41G4g/9ZR3Z+xTvPqbYZXtMUCDhrbUY4NdCyedO1/EJuFKt2j8uDcO+b1ShWA3d/l8PF6829cMxG/oD34BdAwqEu1ni8k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6FJZmdI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762434462; x=1793970462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ycjoU4qZZjVUqSKJvRIjRsx462xz+TdwcITr2Z+pQGs=;
  b=Y6FJZmdI1REB6Y0ZORU+2So9JfwfebVXkrxvnNyWwqWHBdU+1mUnPFHv
   QWowpOqhCSr9ZmCKxQWmpq8kdwOMdD8onIBu4yH1x/BtfcxC2h1KaT3HE
   l4qQghcrCbFD1lFPBDPpvEGp9ZK9G6Sb3KpCGzTyeleMUuuAdgFDfQEAF
   yv7lOlTB7+SOePFpW5uTJO4wA6LFGascJuG9tEOYor4X0sEQB0IQSRjSu
   byOaNple/hXRODAToF02F6UgEgAuYUJNNRpOT1FQu7aztlsLe48xy0tXL
   xRNyNXMMF5afsZzsEZ7mBcnYLG2DUxqoYzSv5gTVz/g+8wLpByfgGzT5+
   g==;
X-CSE-ConnectionGUID: MU5iO256SV+9SYIS/s/vhQ==
X-CSE-MsgGUID: SiKbsY/DTlCPIOuP/bBsGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64483227"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64483227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:07:41 -0800
X-CSE-ConnectionGUID: qNsMdQyrTYqulGgiZ9MwgQ==
X-CSE-MsgGUID: IWYaNm7BQR6b6vkZLd+t6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192109308"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:07:40 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:07:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 05:07:40 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:07:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnqBB1q7RbkeY5G9s5Mjf2wHGUCYl6g4RV3CpRApZqzndp9H8OUllGPRnu/kPSd1DdFJHhs3b2D/wiYmdoT/LiOZPAKHW2bfk8wCBTutfYbdNMTLYNNNhadlrTEpifKRGDnq9oSAXp6J8IY0ZT5R0RFOi9Dbdq/YOJ0Jfmhp+kTJ6xCUZB3LNug9SIga84RZymNkVhb0ahSptylIVwWIGm0N5KqAI+lssxDzknYbA0ENY6C8Pdn07VRdmk5d0enQikuMT0nPip0k8IbPfWYURasX06K+vEfaVHV5dcbXAn0gT9jwOwKhUGjsF+8tap1n8G1chSSuzOBnFpdP9qSYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycjoU4qZZjVUqSKJvRIjRsx462xz+TdwcITr2Z+pQGs=;
 b=vdQOl9n1SezXHUoeVMUl9TEaS388d94RiWJRrbczsYlyS5X/lxQ8FcAbfSNUdeqFocDwBDLl2++rFF4kNERUjdsoLd7ymVBksyvCc+mJe8imvuGfVp1/telUP2fjlgi8FC+r4+kNfxtC4XV8HLAEUHYE8vjrYFd9UFLwo0lnUUXdlkxlEhReL/St8z0OY0ys+zAtX/CSrcinJ4XXJhDeqSnoY2wq624GKNJSU4TFzyN4Eed2p6LlagxDjzFVXXKgQDlWROiCy4mthC0iPdJsYaA/phKVkdF8UvmgjQ/zLSEg9INf2HwfE6v7m7mYTiuEpKPjLEW6w6TSA3CeWGJGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH3PPF8C0509479.namprd11.prod.outlook.com (2603:10b6:518:1::d37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 13:07:38 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 13:07:38 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, "jbaron@akamai.com" <jbaron@akamai.com>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v3] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Thread-Topic: [PATCH v3] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Thread-Index: AQHcTvoT0xOwtSNYu0K3U3v/ycxCU7Tlmrfg
Date: Thu, 6 Nov 2025 13:07:37 +0000
Message-ID: <CY8PR11MB7134D38563B5485D2426CBE989C2A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251106084735.35017-1-make24@iscas.ac.cn>
In-Reply-To: <20251106084735.35017-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH3PPF8C0509479:EE_
x-ms-office365-filtering-correlation-id: 25895817-1577-4f38-ff66-08de1d3575bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?T82tNMqkCT+tESg7oYoZ3wEKGkROLG6A2gyzrY7cCmfCoXJ6AXg/xxUWX8WI?=
 =?us-ascii?Q?XH9arxhoiwP8JqgEmPMJVF+pkfUyR5oUBslUlGIEYeMBNG7IB7THJFFThMMa?=
 =?us-ascii?Q?z6QVoeT24/gVrgB9HtxPbpGffbxIua+LS9P0gIYM6Goll0AEllTdaOa1lOkm?=
 =?us-ascii?Q?9cwf9k+RbKRAs4x86GORYti7jfENuCRQtGEJZ5e7sjAGZ5JFHotnQcHCsuQv?=
 =?us-ascii?Q?dLZZPiPhn0EcxzkUtmSHVdB8qnkLSBTX+0YjYnkclmZ1/zioFEA8TKdAHYcO?=
 =?us-ascii?Q?Ksr2O6ds5KAn7392CQwKXIamjagEKMPnkFUaIl2XnsEB1nuVHWCXNFUB0137?=
 =?us-ascii?Q?PiwKLZEMEryG40bWaKwtmRUkUFXM5W48iRD3o1Ilen3wFAQhXmg01lGRvngV?=
 =?us-ascii?Q?ovfFg0LffAmjyd344VDmrKNn+zCEUXxY+q+zFGoli6jpcEw1TCfXBDQb9KvK?=
 =?us-ascii?Q?z2E9r+3asAeCGI4PIo41dubOoZ8Ahy0NYyd1VtKYA0kktAUIMfZdK282Ep1f?=
 =?us-ascii?Q?Xl/VKf9GfIcKeYNe0O0piCRIz/BPkxPmqk3hbFwi3Zg9paKm89FraajKJo9k?=
 =?us-ascii?Q?lqzKUvkJnitqtQd6WXdOglou1qY43nxe+gv32Xs46cW9C+V1kuBTDQk5gPFH?=
 =?us-ascii?Q?gxuZ/ar1x2z+0N7TnnNUQ3JNphKiSju0akejtUetORWMQmH7CUz4hX+EepWK?=
 =?us-ascii?Q?qsXW5RGsVqOFULZPTN5RdtobTZ9bL59XYhALnqrphNHJl541S4nIoeUWRTqK?=
 =?us-ascii?Q?vTdsprCna67O150qxM88Gpyj5Ly4zZYhZ7piUpEW2bC/fId93bHGmdY4bkOj?=
 =?us-ascii?Q?0r+DM0JHEmacGD+0tLm7ju8MnAe6Yhbu4x+PAYMaRET0DZMzHTxsEUkuIuJK?=
 =?us-ascii?Q?kYJeBiwrES3UXPlWfMvjUhJeg41v7WWy60zqTOeP/qtyognzhoaDPvRQzYGa?=
 =?us-ascii?Q?e1bwk4xB8V9BX2wTeCPcGk3BRmXqeXmk64j0EaUtD5lBu6cJTEHHpoI2ZplN?=
 =?us-ascii?Q?jEsgn+HQch7GQsidiq/4+56C01R+k6D11JXVq6JEUY+9wjUobVQS9948QIFv?=
 =?us-ascii?Q?O2K9s/4ppQqEs2QNRtmIJfr7IGI7l5P5t247xirap7bJfRm9SPruquUH4e4F?=
 =?us-ascii?Q?15oxlYKNUGrHDss8dGnbrDnaEEJe2QeO+wvfLbqorhuWPDT9eQy2pEmabZof?=
 =?us-ascii?Q?Lf+UN03Mct7n51UX36ELLa+TXiTGYukIwnG+9UWe2P/dlUWHMoWDD96j2yzR?=
 =?us-ascii?Q?QQfBHWBFju7tupuBSRbPkFUhZueMnV2IRZQ6DhDs+cgirZoUUYsrNPMSmIo0?=
 =?us-ascii?Q?augLpH/xB/QNjYh9nRG0tFe1gnhE1y4MYik6ywHmNHuCirJETlZMwD8x2TGM?=
 =?us-ascii?Q?cZ2XPkYx5r7lhLyoigl9tJUf0Sh9QyMnvr/wZwsHd99bZIAcNjykIAJpyl7a?=
 =?us-ascii?Q?ZSPukG122lzPrQPK9RVZ32hBI9z2umTukHaJiec8Tpbp1e9PHV4el6J3Z7zs?=
 =?us-ascii?Q?+qJBbEFZ1TKi5dfH3EEx8n03iP3Xl28gtzUT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+fHvzNE52NBjTuXHAURK0G5HuLzpBD2cIiUBAvmjKZd+yy+GPoeES4U7V0il?=
 =?us-ascii?Q?6jcrbJuVpanJISMjcM5wY4UbrS+qdBCTSFtAZ6xNPuVpsqyn8vLx5Gu687ZA?=
 =?us-ascii?Q?ZVnZ9czo3Clu4843Dl7Iik61zHhIjVOek9qPbfh7t1AVHKg7j7Gll3E63o3F?=
 =?us-ascii?Q?OLtG/0vQ23Tm/G7nqNf4XEIBZameHoOueVzMOcKVF5eMdLuK3tCbOnV4QIpt?=
 =?us-ascii?Q?Z2Fqf3Py1NXk3wagbPhHqpb3D2RmzFPeOk9TAIEbuk6sgo4Ouv1DNudarKHe?=
 =?us-ascii?Q?TTFuPNMQgrT4WU7UTG2qebtaepQqxVAzV0Jq9Iyp1XEEfmjIlFrfkNERT5jK?=
 =?us-ascii?Q?pavn1txULbcj3anhRzM4SAHhOPSSe7j9mudjGYRF0V8Jt2Idb1KEj3umQ7BE?=
 =?us-ascii?Q?I7sTzMlzrhHmEkoaR9G/u2YFpgR70WdV+h1so5i48yzzdYOkmi3dpBA9U4gb?=
 =?us-ascii?Q?L7vyR3RT3ZcT+BBOGBJxuiENFyYiV7n58c1C89P2r3HIhCV1j2Z/4nWyZ5Xd?=
 =?us-ascii?Q?aGAoZaz4xhefON+Pa6QeWgneGzDCNFdkTV1vbdMPBKoocZnG5FVRYAdRWE5V?=
 =?us-ascii?Q?aCUkK82jYFJ4yPmwNgu6hKEXu0UlVnp2htycGoiFgdD5kbbrUmnS88j/CNaW?=
 =?us-ascii?Q?a0wfKRY5oMDhYJGMRnPSpRlmfZjZrEP7jFOSF/a9Pt2idMr9i54rh/ujpUiw?=
 =?us-ascii?Q?/b61Oe0kQ/4E318aP1s0OCWCB7QgD/6ZJUih/xMfU4bh9CAwohheuG7QvpRZ?=
 =?us-ascii?Q?IQI54tuhfMLKKcSju3THsJJVMy1/20z6jdRWrejd83I/coPJaiD90hnSUmCJ?=
 =?us-ascii?Q?l3kc+iYOqhgKMDbOhJ10ZU6xFPup1vd/vSrjLyJYHr4lspqi2TiSwWFswejf?=
 =?us-ascii?Q?RDIL9v+h1k+tMU/WontDqfKcpEWB8IA8EVNg+dRlDzC5Rnvc5V9EnUJerF6K?=
 =?us-ascii?Q?bLMI02QzXsgU9YruIWweOfZ4JqSsf6w9pYqdJ254qSV9Xm+cm44El2iJvXgW?=
 =?us-ascii?Q?CqBLKSTV3PrTNMrY/8krFjk5K87te7xa1hpqdkpbU5xnDNVCJMJ3rplvUY0V?=
 =?us-ascii?Q?O6Kn3CdZ7PL5Qd7nDmk3oWDZtzmEspvnX+qq0Ks5+DlLP9NHVdrKdXlWTAOo?=
 =?us-ascii?Q?NJ3cinCT4niG1w3x3WyAdvsxmK6wRG56ouaifBzLjGg8KI7V2nt+NURddEoM?=
 =?us-ascii?Q?R/i5Q4sJaEnim0Yp2N3DOWagqEx7V2sV2sv007vbCDtb82Mcc5XoeCB1D6/z?=
 =?us-ascii?Q?ViTyfSW8WrsuP4605wkbKIIkOo9dld1ajZpyBiZEPxgmnwDYzJBes4iZg8CI?=
 =?us-ascii?Q?3e9dKVW7KyuDFWWPhDNOgQd4obpWloyoVzG9Ta1V2qeFm7GAQnE/6rrjbH+i?=
 =?us-ascii?Q?hZn35iyTn11RscXV9N1oTLsCChCB7f9uXYHRewCQ7IJp5s6NcEQsLK1F6xOt?=
 =?us-ascii?Q?pOuT04/qxgllGcyc0ZzAM+v/+UXcb7PKkE5+Bood7AblHmEkSNI7Yqpr3JAq?=
 =?us-ascii?Q?yz8djEPLR+6DZ0v6WiwsinXICESKDZDjiv94EpaOjFXHiH7bvFOmn/lFXDJG?=
 =?us-ascii?Q?MVOGAwVPMkXJIZHXSA+kxtzJoXZ314RuFpMTUt/k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25895817-1577-4f38-ff66-08de1d3575bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 13:07:37.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ag6yKzsQOoffJp2CQrkOlahqGhcnuxHsAV9ZMR/7+C5ZSGIfAW8xV9z/R0l7wR7P7GWaTI/iDlySWHztzc3ZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8C0509479
X-OriginatorOrg: intel.com

> From: Ma Ke <make24@iscas.ac.cn>
> Sent: Thursday, November 6, 2025 4:48 PM
> To: jbaron@akamai.com; bp@alien8.de; Luck, Tony <tony.luck@intel.com>;
> Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; akpm@linux-
> foundation.org; Ma Ke <make24@iscas.ac.cn>
> Subject: [PATCH v3] EDAC/ie31200: Fix error handling in ie31200_register_=
mci
>=20
> ie31200_register_mci() calls device_initialize() for priv->dev unconditio=
nally.
> However, in the error path, put_device() is not called, leading to an
> imbalance. Similarly, in the unload path,
> put_device() is missing.
>=20
> Although edac_mc_free() eventually frees the memory, it does not release =
the
> device initialized by device_initialize(). For code readability and prope=
r pairing
> of device_initialize()/put_device(), add put_device() calls in both error=
 and
> unload paths.
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - moved put_device() from fail_free to fail_unmap to avoid using uninitia=
lized
> priv variable when window allocation fails.

Oops ... I didn't catch that during v2 review.=20

For v3:
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> [...]

