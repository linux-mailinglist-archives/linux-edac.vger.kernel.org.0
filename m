Return-Path: <linux-edac+bounces-2013-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC799ADE1
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 22:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580A5B244E7
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DE1D14FE;
	Fri, 11 Oct 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVVzEy4t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56170199231;
	Fri, 11 Oct 2024 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680278; cv=fail; b=Alo4RJTaYLm6iD7N3Kjmc3t5KNVc2uxl1zBB7A4Iti3j7BexsnQ/cJlOnUu2YrOP6sdx6070ECBp8rc7q7XYXinM6qJgXBUt2mRJOrZxfpwpGjPcnXUYhqod7U4irxFSBYOojCMXcNtQ/CgkC3muzpz3fDGEcBes7DEx9cR8Qss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680278; c=relaxed/simple;
	bh=Y+UKiHa5NFm6Rj/T3ChEaJsxqZnJeIxDqqP/LdJ2ZfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=at9XP9dgyMdn+5Uczc1SxnQ320Jfxv6qEg1zJtcr7G497zZWRZx4Eygj3SZpKgcw+iVvkyGv0t4DJ6DKLZhSAmokW89OtU/RszHpRy56UD4qxz5TRtZZa2alPv38BuNtVFrgsQDjZP13E/Ygh8KLLZK5xvN2O2N5+cKZu2cuuyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVVzEy4t; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728680277; x=1760216277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y+UKiHa5NFm6Rj/T3ChEaJsxqZnJeIxDqqP/LdJ2ZfY=;
  b=OVVzEy4tTaNWS7dwgL5KeHBtHyFQlUeiTRlZWcwJD/MzsTLGEBlXE4Hz
   FVh8BO1pUI1mnqvrge1N1MWtPfrofa5EkqzoTP1JMAP0kzIM6XUii+dwT
   MNalMnn2ANVWIkh0pSut3O684iLLowvHC0afDy2Jy9plnVBpANEpsYgwB
   TIgSU8ouYYl8Lyfz8ml3jtwJogjzeA2wGOVm6oSde/tgCh86s680aVxyQ
   /D+gSf0G43fVqE58IypE/0sppZEkum7ulTxLH38LUi20bZ2pOUwGTAYI3
   qnClc1rKFIaXcS3WsMICDNRe8H6UccEQlJtWLtZtaxb+TYCpAYUCYAlBC
   g==;
X-CSE-ConnectionGUID: IQdJ65zvTKGFwV/j94I0jQ==
X-CSE-MsgGUID: EyNMPiTbQG2E8DvngCM0Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28219333"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28219333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 13:57:56 -0700
X-CSE-ConnectionGUID: yW/9arDOT0C7V3a+jtD7tA==
X-CSE-MsgGUID: 9QyPohTdRWeAYOKagA7dyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77109891"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 13:57:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:57:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 13:57:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 13:57:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 13:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naShMMYj1Z6McK8pRWguSYZVAKRNDQ3Qaexj8jRCMBPGPUsFtS6A07EBcIOa5KYeXNzck4XSejk51kS5Xko2JMnQ8S+j8Qq4AiGAYNBPeYRQv1D3rtyZ6MP63K0z0tSkrdFZP/xt7RS5Rg+T7D3O4zZA3gYhQtswqDRtkBvZPp1ZbKAk88pXod+VDYzPL6/msOiMQloSjQvXX0p/Fgiuy0qi9BbzLrHDyFh3aQMdsZ3EUlVsrmdDIbf7gKCJ/J4WaQA8o9tIxOKk0FIAD+nUdNoV1B52auDUomuaKdxwztCyDbaBvy0frGfm07dV1AZvZBcjSftnN2sasCjYga5QQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+UKiHa5NFm6Rj/T3ChEaJsxqZnJeIxDqqP/LdJ2ZfY=;
 b=LIRs3ArRFN+aIMgx5pG4L1S4sVLqJ2GGjdIIdPPhruiYjrih4q0iYFsstBVUXgDG93YBgahX+hgirOqFf4yoMw+D73aXdRltgf+SumlGTqWcPdvJ8FMkLL+kzQpaacFGJgCcmCrfNrjaxV5PeyQNw2nix0c53kcG7Ui89ikDrZ/y6qE5yqSKT87qP/WjtrPcA57OwUcImMnA2gczLxGHK+UY/rrir4npHVBaLHLxN7/XGpcCu4vw+4PDpTTLaVtsbWBWHunuMBjs1G+8cyFjVJ2u0dyyuljPcarX226tD13WMBvNWF2fux0DRrufmHAmMxXRhQgAscfXXaWCzn1XnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:57:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 20:57:46 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/10] Clean up some x86/mce code
Thread-Topic: [PATCH 00/10] Clean up some x86/mce code
Thread-Index: AQHbGyydj9iKqVTtXUWqfdJVQfjp6LKCCeVw
Date: Fri, 11 Oct 2024 20:57:46 +0000
Message-ID: <SJ1PR11MB60839A44D95A5BD564FD424CFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4703:EE_
x-ms-office365-filtering-correlation-id: 8a8b5370-9f48-44b8-c0cb-08dcea375bc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/nu++z4ZshBkPKOn+QRhEQ2lkzsUXIk+wkYYY9blrd5LDRvS3y0iMID6Xc8D?=
 =?us-ascii?Q?Yp+yegAeZz1+gqaEYiXR+AV9SCXLjI4jzTSP97s2YnXuHi7sGzci5WJf+AGE?=
 =?us-ascii?Q?hyYd/jdEQ7e7TmnRUwmAWSd0uJtPQNdZq4Mg9WQce2wlj9kNeD2N6/XaTdw6?=
 =?us-ascii?Q?KZO29EZKnRmtN4mitHji2Qda2giyqvzkMaqujYZv/BOh5oc6mYwzqS446mUI?=
 =?us-ascii?Q?rT3xK8+TT3hMT+k06FHZe5RrnR/G5LYftKpXaytjs1AlraDSOMDjTgLbn2Gi?=
 =?us-ascii?Q?oheRPP0d9gkCjVQ+ajzcWJgfbJC5jyEefWyRsItE7bKghE1O6LKvWWJHieO0?=
 =?us-ascii?Q?VmMLdPiu3kBmXbqxTfFvA9JO3+vGvnaa9hRPZayjKrDG3y24X0sZtOIjH5VV?=
 =?us-ascii?Q?M9w9ozXi3lMoZYKUEli/cuQotDnXhTTs09dfW6SDt23qpgtjGg7McGiaid40?=
 =?us-ascii?Q?uDCSF6XLHgPiegHCAXBRHBfVM6fOVBQqk/tSRyGo9Ixtpy3XUM7VnLqvrfHr?=
 =?us-ascii?Q?OSYf+GmkDoInHLYD3afzlLI3x96+QmjD4/aFaJyKFvz14SbGVML5TDc32tBp?=
 =?us-ascii?Q?rEz+DNj8oWsDvIkZ56x2FPAKooCNdd759XiUcvtu8syMiAmlN7QhmuZbnJRC?=
 =?us-ascii?Q?B15gB83sLQVsNMX2BTSsq7oRL2YkYZzYkPQoC3axHxvuGOhDOPKr5zfbATEj?=
 =?us-ascii?Q?EnebPd01p1JLlalU+6NTvffrUdLzSg2BGPzzHSfCSZVNNOQTzUBWRw8pL5yb?=
 =?us-ascii?Q?XwyGNAZOcCB/XRIu/wqb8I2npQ+TC2EJfbIwmQ/BzQMAZqSfEmismhX+Uwol?=
 =?us-ascii?Q?Rjm+FPkYb02FSAwtAIfTeJJbv7xVs+0f3Y1G3TRz2+1Rqc8QbgAP6VB1zrwD?=
 =?us-ascii?Q?0XsoMMkFlEOQbyNiuHdoaxG3H+1vSV79Q9WIQb4maBuj+Rvt1e214SiP2zFL?=
 =?us-ascii?Q?DSRXv1yTUw3KSKkr5JhgLKAAzF0pFE/eN42PAMBvBUKvR142c6lGSivLhi20?=
 =?us-ascii?Q?MNqhTeLKhpDcts7Yazsp7Qs0RSjizl9BiQM+OCEnqbLYtaKkbZ8T4UI5PB02?=
 =?us-ascii?Q?uvCeItZhiAkpj6k7zOADhf4pLkdFAZ69NZfOdjvizIErbh4ViNVjnwp6NuwX?=
 =?us-ascii?Q?RfYEy62uNf5q5Gz8tcBWVjexe+y7v5WpbkBBgT7oRdYxmjbGIWACsGYw+2n8?=
 =?us-ascii?Q?jMaDRVfzG4XRpE0N0BW/FsBNrbD9fu6CrQ0Vos5yt1lgspMV4dd9KuRN8RGd?=
 =?us-ascii?Q?9cHq+BDSquDXz072gfiPkDrd3P3066naM+gzFaKgvffqJMBvtgB3uDhgGO4H?=
 =?us-ascii?Q?BBlQDNoZwrEMZWjS1DpIwcFJhKpVAK8ASLcDRAT4t940gg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JCrb2Ddc04yrp3W6BONENUeex9q1/D8/ixebFdEic6uiBA9jJdukWVxUTyjT?=
 =?us-ascii?Q?DQ3Vf5CLvmsT6VlkIu+VAsoShmr/dwknEz9aZhdsupj0lS/RBo6ASiofMxXq?=
 =?us-ascii?Q?/EsNIkg6H8S6yzC1GMsjYV4emIGdx/Tv4DoB7SFqJWBsTuUd5hjojY4P73kD?=
 =?us-ascii?Q?bwG/ro2x0QLGPZ/dY/oZqeaJj0Pn2V9FjZiiKwCX2uyqIf3ergxHSl+cKYpn?=
 =?us-ascii?Q?GoD8VNiARTlH26g6xzERehtGPEfcwY8LEhkDURTjRe1TqW1sllOqOB2rElRW?=
 =?us-ascii?Q?3t4UoRO/t3jQbLMIivo+XqJjZ0NhK646a1osBkSOTSDZFwmBNsoLygDHIbHh?=
 =?us-ascii?Q?ANyHjP7Cf1leyCCWcXFMuodwO0J//nlw3YXGwkTp6ywFiU1BbJeVTqjJ9i1d?=
 =?us-ascii?Q?opzyJykCa4XmDNHGNqLSfwHQRruPXNBbWRLkN0zSOYVgkcfaS6w1DKvr4SbF?=
 =?us-ascii?Q?Pdd2CoX8CtT13n2vmD7GC9ag2z1+GHcVkcMrbwL/D24IDwx0XSn3NGkHF2yQ?=
 =?us-ascii?Q?lYuwzToTUMvczxJe86JLidSS3pYFTHic0oNCHFfc6rxB/UKvIczzoRwVoZlO?=
 =?us-ascii?Q?fncbe7FDb4Ju/gidja1pt4JkhtC29BgGn4FhQdOXOEjT3H3157LVex0uuEp0?=
 =?us-ascii?Q?mZjCEeoCtVz8td2ZSLPPm4CbO9qqLratUJ74reNS6gY+ue8TziQlxNbKEmDO?=
 =?us-ascii?Q?Zvz+55ZzP/6iMly1kpwd2//kcgcqETUmm2bANc1CpC/y3XzeXtwtz6CGclGb?=
 =?us-ascii?Q?u2hS7iZj1p6ogDLvuMMc8QqHjG9vOlfAbPe7z4u/ZKSAqJixi1oz9N1TXgr7?=
 =?us-ascii?Q?UuHdanbfRDAA0JNvAS7EK20XS9nICaGw4g1is5QhVQ2uPPCu7wGj/ezK8F+7?=
 =?us-ascii?Q?KGWBjWFpG20xrFNIy9WBxMYEmbGZi704n/ztTIQNUCriQpZAk40ubMdwIEl/?=
 =?us-ascii?Q?JarBu1rJLsNlNT7GsQ/IF2HKPdNUozExhkUCAg+lrDZ3o8MY4Ro1YqY46hIi?=
 =?us-ascii?Q?hsMinOT742D5HWAHPc2ijaLj5Lvj7EdSa1dm+KPCG73K4vIFQcYnS+4a5PjN?=
 =?us-ascii?Q?fD9uHQdMdUVQlSnvp9myv7aNoKPCwL2QlHSM69Yw+xPDrimRmk/aKlppBKMY?=
 =?us-ascii?Q?ksafO1wqxobHkI/97t/A7+aLSFPE0wvqpXVzlW3bxOJFXd66oQZQaGCVMLYY?=
 =?us-ascii?Q?FhqOa0fqCAs3oLx6gkaj2qXwXIe+bS/00Ar/1czUFf9oeq1jvgfS0kHKIm+P?=
 =?us-ascii?Q?Jg+8fQjT8XW7rDtUKrTNGlodl6ZJP2mVxxDBInWbqLyiJEbMb0ndaSeNkuAa?=
 =?us-ascii?Q?hMXIQ6fX3BgPnH6brMR08tJclW8uYG302T0sJdAIyczur8jymYSTzmMOdCN/?=
 =?us-ascii?Q?o4ysFeQqEHGXhuuRRWvXKEcu2LsNLEI4ou7Q/sJIQkAJNWcUU3rJfGizqWjt?=
 =?us-ascii?Q?whZiEqELvccrx1CREM9kyRcfpV8b56GHCAbiXjhFS7ct1P6A8YcwqnOKjQnJ?=
 =?us-ascii?Q?P0d2rDIZKgF2AEGIlRXtIJX4fAEWRk0Li+pXRT2NWw+27BbawFUK9ZnCvgtx?=
 =?us-ascii?Q?nIhiLczht7UNKe0jUQvCsdtoCYOMDpIZgewmE6EJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8b5370-9f48-44b8-c0cb-08dcea375bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 20:57:46.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcnWAbzjHcjBJdL/KFaD7iE45V/4FoxYokkAJf0w7TWoi8FhPgakSxodVH2kyoZMvZ8de1PI9OVWZKcSqD4UVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com

Aside from the nit about the commit comment in patch 9

Reviewed-off-by: Tony Luck <tony.luck@intel.com>


