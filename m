Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F705771A8
	for <lists+linux-edac@lfdr.de>; Sat, 16 Jul 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiGPVtB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 16 Jul 2022 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiGPVs7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 16 Jul 2022 17:48:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5D13D07;
        Sat, 16 Jul 2022 14:48:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8lmp005050;
        Sat, 16 Jul 2022 21:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TY11xlPbRqomTB70MZ8c4mkrmFD4gpfOCE3XgRBAQ14=;
 b=FnrlE2bCScdobnjq6n4L7D+XJR0aD1ZR5b52xnIBaBsGArtMqZWyX3CAWYBtOTpoYI1U
 DNkdonR71gd1Lxqbhhedj3uulyapRV5YTfBvwJjd+KCHRoDrPvwwvzDqKIVMswuEfQ9Q
 avwGA2oKA76EZXgdLL0vHNWCPz0e28+YzG4XtFQNMAVtw4Oc4+68+wIHas0XCyKNPeoY
 t3/NcVnx4Jwg1M8o3sHUeNnBvPtw2wNOMMxzP4LlC8rxIuGD1QMlvAvFNyC4QzIspbHE
 x3aFLMJ7g5Gi4Y+QTrDhqS5FGmjMVC8VKuyyMhsaukHjsYtaYeAlBJN4OzWld5sZuYQl Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0r68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 21:47:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GHDef0005172;
        Sat, 16 Jul 2022 21:47:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hq29vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jul 2022 21:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKny6CLex6YnYPyQbxGnd5pu8SlkOgzanPVR+bAymWhML81BYWjBN1xHDRnIOb8hk5O5O+LLB+jrsgvuOoeUDXi6C/9iX3vkUQlWXbOq4TwOQg1iR2SQaqf+PLpJtEs02/lP6EJobzazus5dx6esRSDTvEm3pMf10h0x0AczWHY54aGUolqsSRwOaSfr7tA1T1uTBMYA8ryXX7rnwZYkvnwTIwZkbrg8yokAMFU96KdyaNAfaKjDDUgCDowvmec3Iy+Bnm5QKRu3DeXy/+B4G/Kre3Vu1rQpCQWJNdsHyFu0Hy/WivZTil8MDuFdKAHi8LR5f1CPQkx3cDZQYsy8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY11xlPbRqomTB70MZ8c4mkrmFD4gpfOCE3XgRBAQ14=;
 b=feyDG4vG6KKI0xG9YzWiv1KqSGzFvCJUDn3LRdq/fuWQM3KjfUHLyhAeQ5+lkzCpU7JOiuWMZ32D5MJb2qiH27S3tGu1fBtymYFOoSm9Vcl6aSMpvVHRm1NyB3gV74+FV3Rb8o9fpkmY3SllxVvrshT7e9//6UgddVA5AXVYHddVQl1bCFxdWWrGuZG+SX+TnXk98blRqfcI/bcuJvCtx8gAhZrqfeUOmdTzrZjO0u8IRCQIyd+xseJyJpdjPxKg4LLZR44WrZiJtSy1RyUDgYLboiN0s0AEUhUb4mgOgK5kIvSiGcSez+yN1lPNS39lAHcxOMvD6swgbfXgljsntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY11xlPbRqomTB70MZ8c4mkrmFD4gpfOCE3XgRBAQ14=;
 b=ScBT6CmaruVRgcoUr2hi3bZydSs970MKWCD1TcToQezIAzgZGART1Nrc8QDRMd8413fij4I27+OsVDO7UmezEbwbmbJfLhkJru6Ag2lGwABKEtnmXclifwlg1SQpfhlp3FKi7ZVtnv+xzmYCq7SwtcVpRVBvrijwfhhtapknqxw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3398.namprd10.prod.outlook.com (2603:10b6:a03:15c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 16 Jul
 2022 21:47:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 21:47:31 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2] x86/mce: retrieve poison range from hardware whenever
 supported
Thread-Topic: [PATCH v2] x86/mce: retrieve poison range from hardware whenever
 supported
Thread-Index: AQHYmMSCb55BfVhzDkSb+0u2QGvneq2AbaOAgAEcHwA=
Date:   Sat, 16 Jul 2022 21:47:31 +0000
Message-ID: <d6ed3dc0-3ea3-01c7-8096-50ae8ca45acd@oracle.com>
References: <20220716033104.903163-1-jane.chu@oracle.com>
 <62d2439bbeb43_242d29450@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d2439bbeb43_242d29450@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e618643-a39e-480b-0efa-08da6774c8fe
x-ms-traffictypediagnostic: BYAPR10MB3398:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?U2FWRjVsc1ZXdXZPSWdPMllrVW82SjErQnVNRjE4TEV1OE5saFpXcXZNZ2wx?=
 =?utf-8?B?dFloOUIyWmF3cHV5d2hBWmM3bTRGZEJDZXhKdVlBK1NhR1pjVGh3S0hBVW5s?=
 =?utf-8?B?K2NVT3NEZVkwK2ZxZjVIbEg4RUlaUWZLZzhyRzg2SHZVWXd2cDhvbktwMDBR?=
 =?utf-8?B?azJMUFU3dFNWcFVGYTJFZmhjVFFWVnBYVVZYSllwY2xBV1djalB0Z1NlSGY0?=
 =?utf-8?B?R0Q4TzcxT01oRFlUdWVEYnRTR1E2bW1oOVhMS1pIYXN3M2czMjdmZTIzMkxW?=
 =?utf-8?B?ZWVmdzJDZlRKTTRCNTV2ZTdKeXl5Z0VFTlBkTyt0Z0JVUTg2aEFjNVVZR0FW?=
 =?utf-8?B?V1VsTGM5ZXc1WjcraGFOaW1TVXJhQnlDYndMemlvZjV2U1NoaHpYaUp2bmZU?=
 =?utf-8?B?ZXU3S3hpalZYSEVIR3FOSjF4c2IvbW5QM0kwdWk1WG4wb3BQaGk1QmpHK0xv?=
 =?utf-8?B?Q2w1OXIzTW9yQ1ZTSlNmeWJiL0NaUllBMlNBa253dkJLZldveGpoUE5ETThz?=
 =?utf-8?B?d2hRaTV4QzVic2hLeG5hcm1rbjdPRUdoQS9HeDdzRmhITFVzd0ErKzlFMkNN?=
 =?utf-8?B?RHJOZWdTRXpYVTBjME1YQXpZWFV4MzhzRCtuZGdoVThOZDF4djFwcFZtVjV6?=
 =?utf-8?B?TUFGY28ybS9kNldicngyN2VCb1RTLzI4VjVkL3NsblJGSGRnRUJpWFY0SXNR?=
 =?utf-8?B?ZU5pOTkzTkt0UVhibnpPdmx6aWg0YXZicDFFWG5YQzZJaGN3WlpYeVNxUXpa?=
 =?utf-8?B?WGlLNElnTG1uUHU1N2NGVEZabllXbG04UkZKc29tYTVTai9mZWxyemJwK1BL?=
 =?utf-8?B?K012bEZHSytqVFl2ZWFSc3BsYlBRNytFaElDb3Y1Ny90NmdIM2lWeDFaSWlM?=
 =?utf-8?B?cmUyd1hMemkzSTQ4Y0MzTHVhWGpPdEdtMTdLQlJGUGszYW9kWDAvL3R5VWhK?=
 =?utf-8?B?RE9vRUFXenZBRnV0bTltSmI0dXNSWisrMjdSd0UrNkZZa0Q3T2hOQ1FhS1Bj?=
 =?utf-8?B?ZW5FQXB1Z1B4c0VoTnFhUy8wdVlzVUtnNVBCUUhvL2RIRnA2b291M2hhQUJ4?=
 =?utf-8?B?Ullpd0RHREVZK1VIcUpITjJNMmdGOEJaTTlsUHhFTVp2T0hzbENuclV0N0kx?=
 =?utf-8?B?cU1SWVVLeERYS3JTMUZwZFJod05CVVR4S2RJaEhRQ3cxdVdmeDJpanVybW1S?=
 =?utf-8?B?UVBzdWgrZGZ5QmVCa3V3eWNQKzdFRVB5Y0NlNXpaWDdUbE1obmJmMFBreklY?=
 =?utf-8?B?TmpSM0dNMExqYzM2TGlGS3JZQXBFWnJEaGZXMkRPUmZLdmQwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(366004)(136003)(26005)(76116006)(8676002)(66446008)(64756008)(66476007)(66556008)(66946007)(6512007)(8936002)(5660300002)(186003)(86362001)(7416002)(44832011)(31696002)(921005)(38070700005)(478600001)(6486002)(966005)(71200400001)(53546011)(6506007)(41300700001)(83380400001)(122000001)(110136005)(38100700002)(316002)(31686004)(2616005)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akppKzJSakVCcU1tL2REWlM4V2JTb3ZrT2NHTkdqbERaSG1kM1ViTWxkU0hM?=
 =?utf-8?B?T3VIajFHQ25tMnM4Yk15QkJ2aDZZUXBSNWQ4SmJxR3l5RE0vdUFmWFV0ZHpo?=
 =?utf-8?B?QnpsVXJFaVJEeGV0UlZGTUgxUm5hWHNVR2FHQXF2QnJBTkF5YnRrRUxkQVpl?=
 =?utf-8?B?bmVUMFhva21VNkt1VUFpWFdSdzl5Y3FONC9WekRpK2oweFFVOTFaMmduZXMz?=
 =?utf-8?B?L1RqQWVuZ1MyYUJWZHNkNmhUZFVMaXpTeTVpOXhtb3NOS2FDczJybFdpZkgw?=
 =?utf-8?B?VWlHQk90Y0FERlNRZGFkbTBUTHpBZjhmcTQxZDRmdnFTYndlSU9Jbm8wSmEy?=
 =?utf-8?B?UHkrK2FYSC9QMXdOK0VnR2R0T21yRllPeXo2UDgzYXNSQW1TeDEwQjliQVN4?=
 =?utf-8?B?R3UzWnYzbkJCeGlOU0lEU3dJandscGs2SW9Nc240OTRQem5DVVdRV3JMTjlF?=
 =?utf-8?B?Z1BQak5HYS9NWjBWclV4U2pRdjcrQ2NCWno3VkI1UDdMR2FrVU1qNEpUbUgx?=
 =?utf-8?B?aW5SREd0NmNCMVU5dHBaVUJWWlNGbVg5OEFBdE13aXlzZ2N3MkdEVkY1V2lr?=
 =?utf-8?B?Y0RWcDFDMlFzRE8zWXR4K3hSa1hiVWwxOFFuOWlPdm5nR2tFclNtSDlTSG9N?=
 =?utf-8?B?ditoOTFmcmhJK250dk5VdUY3OFVYREgyOUxqWkloQTUvSURaZXlTWDNqOWd3?=
 =?utf-8?B?Z0RlWm04YzArdzFCTFhaNTdPQTRpUnV5V05oOTZ5aWJRZEx0QUJraG50Uy9i?=
 =?utf-8?B?YWtGelNuTXdlRit1MWdkOG9GSmFSWnprc1R5L3F5RFJNdjlLMTRKR1hNakpZ?=
 =?utf-8?B?RVMwaHJPYzcza0Nuc3NwU0txZEcrL2VhNTJMMm4wL0tBKzZVWHNBQ0hvMXNq?=
 =?utf-8?B?T2dzWHhjbHBKYXYwdHJxT29iNjBuL1I4UWRBVHdQaVlHK052MmRVUnJxZ0d6?=
 =?utf-8?B?TWhDSUZnM09vVWlTam40dGtCdWErVnBzOEdjUmZnSkdoN0plU0gzaHRGQkNY?=
 =?utf-8?B?WjV6cXJkbXdJM0dWeG1rVUU3dzBCSk9UWFBzcjNSMHVsUDVWQjg1ZE9hK0F5?=
 =?utf-8?B?N0IvK2cwYzVwMy84anM3eHE5YUlnNjhjM1cxaHJKVHRMUHZTZUtFUWcxcEFl?=
 =?utf-8?B?ZEFnczBWbnNKT09JYXpQd0pWQUtLUmcyZlZDcVZyZnIwam9PY0JLb3gramh6?=
 =?utf-8?B?MFRIdThYOC84bFBRODZZQi82aDhxZUtFbkJja28yQytDemNza1RuSlk4N1Ax?=
 =?utf-8?B?MTRFUXhYVDByTUVkRnVyS0piYXpuRUZ5MUR5WHNNQTF4Z0hFRldlOXhhdjV1?=
 =?utf-8?B?SmZHclF5eGxDY2ZNNTNWTGw4azZUSCtETkhyYU1BTHRIOG5sSDI4RkJsc1cw?=
 =?utf-8?B?bE12eCt6VWZ1M0wxdWNxZTdqN2dQNVRWSE1DZVBhQ3dtb2ltWit6ZldlcEFt?=
 =?utf-8?B?c1FPalhmTmtIbng2RVZGQ1BLTWMzTXIrUFJmWWdxVzdDWVRUTU9hU3JoY2ZZ?=
 =?utf-8?B?QXhVYmVxUHlMVWFrVFZZOGpsb2tTRkU4dkp0YUlOa20vejM0K2l0eEFpQTFQ?=
 =?utf-8?B?S2lKR3lxMjJNOEFmcnZUYVpsOHJlbGNVTjZ1dE5jVjNGQXBPUzl6ZlFXd3B2?=
 =?utf-8?B?QU9XcURNYVhQeVowWWx1NkdxQ1NRbDJpVGR1N2VZNmxSZDdWWDdYeU02alk2?=
 =?utf-8?B?Zzk4Z1dPQjRKSDd4UHVzUkl3R3o2dzN4Q1RDbDZZR2ZsR3hoclJVUG9VcWdj?=
 =?utf-8?B?T2ppRUUvekFha1YyNG9RUHJ0bWt6N1gyOHQxQ2pjY0JsbWdXQmlpalloZ0Z1?=
 =?utf-8?B?WGovbEhLN2tvS1hkR1d6ZTdpY3dPUVBPS2xPU00waWszU3ZCTGpwS2dsNVYr?=
 =?utf-8?B?MTRyQjFzWUpZNzR6QjNyQVgxemF5U1Rnd25HdUVRZ0hSbFZiRFNBcnZua29W?=
 =?utf-8?B?aEI4M1d0cmRNQjl3VHBxaFh3ZitjOE40NnJPbFF0OVJoU3RMNmpTVWxOQktV?=
 =?utf-8?B?Vk5wUkwxTXZpN1ZOcVJUUWl5SGxJL1hwYkRia3lDT3hQemRXR2VRYVdPb2s4?=
 =?utf-8?B?cHJNaGwvMDh6L0hGclRGQjRYcHNBaWJ6MjFRTjJ0R01ObXlwV0crV01Zcmlo?=
 =?utf-8?Q?sIJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B32FC0DA674C14CA80183A963AF07C0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e618643-a39e-480b-0efa-08da6774c8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 21:47:31.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ON2omSM2TUVA44PgBx+AvwRWKTQaRt/eoit4JrGJ9udOfLlvmJO0ddsQkmFy935s+YVo1DfmOGF6PPGs6ccvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-16_19,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207160095
X-Proofpoint-GUID: KgUq3oBIbSNbbs4PGctkcaYC1WCWbojA
X-Proofpoint-ORIG-GUID: KgUq3oBIbSNbbs4PGctkcaYC1WCWbojA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8xNS8yMDIyIDk6NTAgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gSmFuZSBDaHUgd3Jv
dGU6DQo+PiBXaXRoIENvbW1pdCA3OTE3ZjljZGI1MDMgKCJhY3BpL25maXQ6IHJlbHkgb24gbWNl
LT5taXNjIHRvIGRldGVybWluZQ0KPj4gcG9pc29uIGdyYW51bGFyaXR5IikgdGhhdCBjaGFuZ2Vk
IG5maXRfaGFuZGxlX21jZSgpIGNhbGxiYWNrIHRvIHJlcG9ydA0KPj4gYmFkcmFuZ2UgYWNjb3Jk
aW5nIHRvIDFVTEwgPDwgTUNJX01JU0NfQUREUl9MU0IobWNlLT5taXNjKSwgaXQncyBiZWVuDQo+
PiBkaXNjb3ZlcmVkIHRoYXQgdGhlIG1jZS0+bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVz
LCBoZW5jZSBpbmplY3RpbmcNCj4+IDIgYmFjay10by1iYWNrIHBvaXNvbnMgYW5kIHRoZSBkcml2
ZXIgZW5kcyB1cCBsb2dnaW5nIDggYmFkYmxvY2tzLA0KPj4gYmVjYXVzZSAweDEwMDAgYnl0ZXMg
aXMgOCA1MTItYnl0ZS4NCj4+DQo+PiBEYW4gV2lsbGlhbXMgbm90aWNlZCB0aGF0IGFwZWlfbWNl
X3JlcG9ydF9tZW1fZXJyb3IoKSBoYXJkY29kZQ0KPj4gdGhlIExTQiBmaWVsZCB0byBQQUdFX1NI
SUZUIGluc3RlYWQgb2YgY29uc3VsdGluZyB0aGUgaW5wdXQNCj4+IHN0cnVjdCBjcGVyX3NlY19t
ZW1fZXJyIHJlY29yZC4gIFNvIGNoYW5nZSB0byByZWx5IG9uIGhhcmR3YXJlIHdoZW5ldmVyDQo+
PiBzdXBwb3J0IGlzIGF2YWlsYWJsZS4NCj4+DQo+PiB2MTogaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMjIvNy8xNS8xMDQwDQo+IA0KPiBUaGlzIHNob3VsZCBiZSAiTGluazoiIGFuZCBpdCBzaG91
bGQgcmVmZXJlbmNlIGxvcmUua2VybmVsLm9yZyBieQ0KPiBtc2ctaWQuIExvcmUgaXMgbWFpbnRh
aW5lZCBieSBMRiBpbmZyYXN0cnVjdHVyZSBhbmQgdGhlIG1lc3NhZ2UtaWQgY2FuDQo+IGJlIHVz
ZWQgdG8gc2VhcmNoIGxvcmUua2VybmVsLm9yZyBtaXJyb3JzIGV2ZW4gaWYgdGhlIExGIGluZnJh
IGlzIGRvd24uDQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzdlZDUwZmQ4
LTUyMWUtY2FkZS03N2IxLTczOGI4YmZiODUwMkBvcmFjbGUuY29tDQo+IA0KDQpHb3QgaXQsIHRo
YW5rcyENCg0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBDaHUgPGphbmUuY2h1QG9yYWNsZS5jb20+
DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jIHwgNiArKysrKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+IGluZGV4IDcxNzE5MjkxNWYyOC4uYTRkNTg5MzYz
MmUwIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+IEBAIC0yOSw2ICsyOSw3IEBA
DQo+PiAgIHZvaWQgYXBlaV9tY2VfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2ZXJpdHksIHN0cnVj
dCBjcGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgbWNlIG07
DQo+PiArCWludCBsc2I7DQo+PiAgIA0KPj4gICAJaWYgKCEobWVtX2Vyci0+dmFsaWRhdGlvbl9i
aXRzICYgQ1BFUl9NRU1fVkFMSURfUEEpKQ0KPj4gICAJCXJldHVybjsNCj4+IEBAIC0zNyw3ICsz
OCwxMCBAQCB2b2lkIGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldmVyaXR5LCBzdHJ1
Y3QgY3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCj4+ICAgCW0uYmFuayA9IC0xOw0KPj4gICAJ
LyogRmFrZSBhIG1lbW9yeSByZWFkIGVycm9yIHdpdGggdW5rbm93biBjaGFubmVsICovDQo+PiAg
IAltLnN0YXR1cyA9IE1DSV9TVEFUVVNfVkFMIHwgTUNJX1NUQVRVU19FTiB8IE1DSV9TVEFUVVNf
QUREUlYgfCBNQ0lfU1RBVFVTX01JU0NWIHwgMHg5ZjsNCj4+IC0JbS5taXNjID0gKE1DSV9NSVND
X0FERFJfUEhZUyA8PCA2KSB8IFBBR0VfU0hJRlQ7DQo+PiArCWxzYiA9IF9fYnVpbHRpbl9mZnMo
bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrKSAtIDE7DQo+IA0KPiBKdXN0IHVzZSB0aGUga2Vy
bmVsJ3MgX19mZnM2NCgpIHdoaWNoIGRvZXMgbm90IHJlcXVpcmUgdGhlIHN1YnN0cmFjdGlvbg0K
DQpXaWxsIGRvLg0KDQo+IGZpeHVwLCBhbmQgeW91IGNhbiBhc3N1bWUgdGhhdCBwaHlzaWNhbF9h
ZGRyZXNzX21hc2sgaXMgbm9uLXplcm8ganVzdA0KPiBsaWtlIHRyYWNlX2V4dGxvZ19tZW1fZXZl
bnQoKSBkb2VzLg0KDQpJIGd1ZXNzIHRvIG1lLCBhIG1vcmUgY29udmluY2luZyBldmlkZW5jZSBp
cw0KICAgICAgICAgLyogRXJyb3IgZ3JhaW4gKi8NCiAgICAgICAgIGlmIChtZW1fZXJyLT52YWxp
ZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQV9NQVNLKQ0KICAgICAgICAgICAgICAgICBl
LT5ncmFpbiA9IH5tZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2sgKyAxOw0KaW4gZ2hlc19lZGFj
X3JlcG9ydF9tZW1fZXJyb3IoKS4NCg0KPiANCj4+ICsJaWYgKGxzYiA8PSAwKQ0KPj4gKwkJbHNi
ID0gUEFHRV9TSElGVDsNCj4gDQo+IFRoaXMgZml4dXAgY2FuIHRoZW4gYmUgcmVtb3ZlZCBhcyB3
ZWxsLg0KPiANCj4gQWZ0ZXIgdGhlIGFib3ZlIGNvbW1lbnRzIGFyZSBhZGRyZXNzZWQgeW91IGNh
biBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+DQoNClRoYW5rcyENCi1qYW5lDQo=
