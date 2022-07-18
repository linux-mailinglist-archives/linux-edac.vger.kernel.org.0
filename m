Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D93578C85
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiGRVMD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiGRVMB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 17:12:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0D313A4;
        Mon, 18 Jul 2022 14:12:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKihoT024556;
        Mon, 18 Jul 2022 21:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+6F2F83FjIjGAGSJgKdiiCqy3LSq2HMkasOycfVNRlw=;
 b=njfo/NJxH98rDIUBamWlumu9n+NnimLnVsOwsLPZasWN6rEwp38QqOyJYWBcfW8aZKnk
 mGCdpyq2so3UF1zbpk8PHWPsvuTFN+7hOgL/3R1Ef5UWRoM7oQJxohYjTx81UhWD3KH9
 /l0yTpgUa0N12CmjgHIK0EM1lH34DxeHqld3EIpKam2ZqQAqpBOgLzMFgNdCq3LxNIgc
 b11v9kwx9g7esBgZeJwhwJhFECsScoQlwedZR/u5r62Hwi17ACGK3x5OJs3oKhcro9J4
 /Yfz95zHkC1Y3w6vxjF17usA4Eja4mwqW5i8oiTzLmHuFp71WY4rfz+4KsSrXc+NC8PG Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42chyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 21:11:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IJNjFc007908;
        Mon, 18 Jul 2022 21:11:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1eky25s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 21:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGgC/0KrVeB6NTwY1RrnZ8tTaR5fNgopcsVij45oJBw5r0UvJPd3YiX8K+LWSF9SdgwC9ErHGhLs2Wil6PQbo0135OeD30ihCoWYnWj3mUHPKYbMICQ5BncV5pOWnJ+RswscY4dx3lbh6veGCJCHjQRcAbQbPGivr4CpyEOwB00LdbOXWdZUDyMz/1EUsJGA27L1Cu/d+AJsD3ex9aqKdoVzVA3L6Bnnc3XQVM5KSIEqnhxwUyCv9nYe9hkWTjxF2uVyIpUdAePnKI3JXP23SJF3rcu7WHIDEfBYTa1KVRp6jKfc9y91uDvuer41mAFpJRpqK1FkcymgnP5o5nVKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6F2F83FjIjGAGSJgKdiiCqy3LSq2HMkasOycfVNRlw=;
 b=HlEMYBnfIiLhbbh+9Mrx6+J4F9Vtvsx4N2QJBT8IArUHgUtN+1meuxKfbTm3sHM1lYTJ/20lIb1Q57fH8giI1rnpjpVs2hLdDqHU8jyYgIwHWcZbW1utIcSQ73J8cieBJpEBptj6ZI1HidHIRCPBvErkvomrblGeDXKy2DdDZjryGIBujiLErxJZL8UdXAuYSMG3/t1n7XAXub9wY22NyHkq8khrkNuY8HUHARz2Tb4LW01WGV3ylG1D33Xm44Vit+QjK85yR/xyhLZA7iFAHmznpps4djiwU6+ju1FoAAq7ndNFI7UP95m5sDPMJlcZrdUaIPWpnFGaw47mCrpl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6F2F83FjIjGAGSJgKdiiCqy3LSq2HMkasOycfVNRlw=;
 b=T4KgfBv2iqAbhcrteaB56nwiC0mnVtRjRIxcuFqkVT7uxLKZFrKP3Ior0UA2woZvW7RvZqhq7S0Hn7ATqvheSzaw3jOybbeuVbXNFYsqUepRQpVYzZDJHOAEG3dk5rYEU687Zy8KqkkTJbIeQvF0aozfUF4e40kP7oWVbq155Dg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN8PR10MB3250.namprd10.prod.outlook.com (2603:10b6:408:cb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 21:11:33 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 21:11:33 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v3] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYmje05I5r3RMrz0KkEJP5HlL4e62ET/qAgAAw+ICAAAIJAIAAHn2A
Date:   Mon, 18 Jul 2022 21:11:33 +0000
Message-ID: <5a92e418-9f50-8212-92a0-4ac39cefa9ef@oracle.com>
References: <20220717234805.1084386-1-jane.chu@oracle.com>
 <41db4a4b17a848798e487a058a2bc237@intel.com>
 <62d5b13b2cf1a_9291929433@dwillia2-xfh.jf.intel.com.notmuch>
 <797a2b64ed0949b6905b3c3e8f049a23@intel.com>
In-Reply-To: <797a2b64ed0949b6905b3c3e8f049a23@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da21e063-5d0a-49d4-b021-08da690217df
x-ms-traffictypediagnostic: BN8PR10MB3250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uypuDXSBt01yR+qtzwmiF7oK2iHQkBaOaa7l9E38mbLw/lKqsICC6Gf3N1QEJ+YbZd/rNBpY/qodcv//QbkbsRyjBxC/nxpeRnG20lpuo6N2ZsWvvGM/BHXhzOXDIwxxscKic7B75hW/mEm83N8inxmNjSNmeWE/QG7O2vgVUtSQkkr8jNNVAqHaijsLbZeFo8msDttnmP0tWiLKCSCHwZkFMti8BQnq4OPjBtSf/KptLBn1pPKctgne/CL8D9fmxenRfT1yYULOpvT4cGUQdJMdy+TOgkTiyDjCZfo0PX/pKlnmQ6uY+ayK4anSlPGOQhmEmZN7tHRRzCEoIDXU2muhUHh16m9c9tqfdq8w6SUXZUxq6gUVSEBRqJSxAdFa1JcVYs28S16M27NMWiIEWSQCev4wmzktUNNw5UvXhYKmR8onViu5nlqcF97gl7DsfuwoNfusVBb2kS98pid9cS/KxJa0/tJ0j45oW16vySpF0cqw0ybD/WSC6oJvvTJox0H2fbrghzmwYAyf7u17YjZtILMZhLkIbQ9853jVo5D90HhsuqJrt8YbQxAhZQNNs0RSWzlSNPP+eieqn8KNVIjxjn6QQo1OmrsgpUeYfQFMMB7QZMZboM+yb+C7nmybnhjqtCtfLxo9Db1YLviOe4CFP1yauCFVWGalIg9+1Tl9OTzqvzBkoBSB+eEJEkCzDDHiTRkryPJqZlU/Avz9b72URyIuMnnLMyJVZt3j/df+IMkySsMvm9QK95tYxvZs7clz4LiI7o7Qk3WN3Pmw0CL06Jn0/SdsFi9fed0FxhtkdzujIzXv6XDacslsJLn3p2nfzBQe7rPMjA+aXMDmmNG1Ec9Tx/K5as1cdDmAWwYp08kmTFhY77ZyWrRVtwQa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(136003)(366004)(64756008)(66446008)(921005)(66946007)(66476007)(91956017)(8676002)(5660300002)(76116006)(38100700002)(44832011)(31696002)(186003)(2616005)(4744005)(478600001)(7416002)(66556008)(53546011)(8936002)(6506007)(6486002)(86362001)(122000001)(110136005)(316002)(6512007)(41300700001)(71200400001)(31686004)(26005)(2906002)(38070700005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdLejhDWktkOVVjZ1EvcHBHdy9XUlVnSHdzZlovemVHQVRmcXl5VHlCSzJT?=
 =?utf-8?B?RXN4L1pVdWx4RExEbmlzRnE5eGdvZ2JUb0lSQzdyV3ZyenNmS0tRd0JhcHc4?=
 =?utf-8?B?TmlkTFQ2eDd0a09lOEN6SU9PbW1OOHI5NWxVTm9wZmk3Q1hEU3JrdUdLc1dv?=
 =?utf-8?B?b3BPUXVrT3hXVm1LTk81V2lYZW5hTHkzeC9aNXJZTUlRaGhGekNHcEFIZEU4?=
 =?utf-8?B?NzVublpRbk9xVXJJMG1qdXo4S3l3STZnNVRvVHJ5dlp5QnIyQi9uVC9rZE5T?=
 =?utf-8?B?WjZEOHFjVWhxazFrUFlrTEN3Smh0aGl3ZUdaNW1BUS9XVTUzUFF1TzVHaGxP?=
 =?utf-8?B?dWZncGVwNldDWVk1Y2hhQStJcFpCZTMzNDJyeFpOcXZiWUhIUFc5bXBSdXRm?=
 =?utf-8?B?aVRnNlJMRXo0aFFmYWhEaDl6OVN5NU15eDUzMU9RVVRhSkZxUHU3YmhuckNQ?=
 =?utf-8?B?ZWxqK1lkWEpRNlZ4VzlTU0Fvd0NudUw1S1pVdHBTSEZIMVRqY2ViWFkrbUFX?=
 =?utf-8?B?dmRDNFJzSmczNVRLRXExWG0xcVFXeDBadU14MkhYSnlPTkk2cW0ybGU5WFJY?=
 =?utf-8?B?TTF6MTZhb2t2MUVGMURnWmFQM3BrclpOTWkwUFNZL0hteEcwbUJXS3dldW9P?=
 =?utf-8?B?czZjQkZ4YXlsMkN0Q0h3ZnlVcXIrZFRJVW5zVmxYWGRMUTVEcTJ3eTZIZWp4?=
 =?utf-8?B?Tmx5QS8wVWYxdTNMT0ErNkhHbXpTMlpTS3h6RjhDbFRJOXlJUU45Zk1EYXlR?=
 =?utf-8?B?UitSV2RpWFQzTWFjS3NTRFE5STdhcjJYVVBybHQ5R21CMkRjZ3U2M2VGaXN4?=
 =?utf-8?B?WTd0SEVNUVY5VHJmcnhEb2V0dExPWTJuZUlFZ05BeUNHSGhmVkNJYXVnT2l2?=
 =?utf-8?B?N0kxZFlYMkRyeTFNNFZvaGg2VFppSkFTSGszaWE0ZjlxVzMxSmlRbmhOSXVl?=
 =?utf-8?B?UGh5RDFDaTJidWRqZFdvYWR4bEVJMFRaSmR1U05mVDRBbTE0TDEybk1rZWpV?=
 =?utf-8?B?emRzM2tOOWhhU2dITXlRWC82MXNpSUxqclBFMUhtN052ckhXUU0wUVJtc0RS?=
 =?utf-8?B?NDdkQWt5VjhnVkZjL081a0ZaN2FObjlmNjI0c1kwZEFKWWZtc3ExY01XdFNU?=
 =?utf-8?B?SG5mSW1XcEVKOVU3VzRaYXVWS3lMUkZhRmd6SzdPWUlyMGp2a3M0QXFrY01F?=
 =?utf-8?B?OENDVGtVL1JQVmJTQ0dOODA5bDR4b1Voa1lHdC82Tk8vWExRWmlERWoyTHdx?=
 =?utf-8?B?NmlPTlRtWUtnQWllTy94ai82N29RRFA4TmZURGhEWTBuT2M3bFNMOUZWZFZ5?=
 =?utf-8?B?RUVURmM0bmVTVzlkdUpOM0FLamhGTElLMUxBKzBvdWFWb3RmYVlyYitvRUx2?=
 =?utf-8?B?MkNUT2xqYWxXU2JxSEswNGRoK2ZvZm1nZFlxbFNLbUZrWXJOM29jUXJmR1dY?=
 =?utf-8?B?dmxCTUp6Mmg0bUxLU0pEK3R3TTM2ak5nRHp4RUswVWwyV2xDSTA0RVRDVkVB?=
 =?utf-8?B?Y2lwbDNaVnBIS0s1MEV2dUdReDJ2MDhQdlpiMWZEbkxLSFRoOEZGeXNyMURk?=
 =?utf-8?B?SVVaMXdKUWNwRVcxVGk2QjdHTXBMMzREbGx2eXJkUUtQNGhWYnd4c1FIU3Z6?=
 =?utf-8?B?bVVVTmJsdzg1cGlSalI5V2hnM090U3d4c3NrNWFxOGpqMzVZZ2ZEQUNyUVdr?=
 =?utf-8?B?amF2c0tZbi9WbzJPbmgxRi9taVV2ZS9FbFFBQ2Z5WitMaWxqYU53alFnT0VE?=
 =?utf-8?B?dWNpU1JwUHhSamVUWVRPbzl3Z00vUTlkaTdJa0xiTjN3TjNuZTdmMjl2VDRW?=
 =?utf-8?B?SkhyM2F3aFJqS1lhbXZrb2JRRG14YzU3a3p3VzVlQmQvaHFYdzdsckdEbGhE?=
 =?utf-8?B?SWtoOCt4MGVvVnNoS2h5TXljWXEvb2hKZ1FQRGluRjdmZWhXdGtnMEFZVFpo?=
 =?utf-8?B?VEVtVWdjQTF1RmhhajNqSGwwa1pYeWlpOFpOWjZ0ZVl3WFhqRStyVkh1eEhY?=
 =?utf-8?B?OVd4VHRYYllCNlJnSW1acU9mRTlGRHJWa0lIa2ovek0vblBBUjhRMDlEWlhh?=
 =?utf-8?B?ZmNlQ2twSFB6Rk0rSklIVHpuY3ViL21SQzQwYzZndDB1TjNkMUh1c1gxYzN0?=
 =?utf-8?Q?Ae28=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD696DB87C43FA43B3AF3EA9DE3AB26B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da21e063-5d0a-49d4-b021-08da690217df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 21:11:33.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fa2KBambh6nkuBS3bS5XgMbOGpWjJoITDEXUP/HSrsQdehPODeDcXyf5K9KI+gWCBxu21si0w9RTNgz60MsM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_20,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180088
X-Proofpoint-ORIG-GUID: 8hzOuoecolRz6NW_QBBzwDJwBMTuzEhI
X-Proofpoint-GUID: 8hzOuoecolRz6NW_QBBzwDJwBMTuzEhI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8xOC8yMDIyIDEyOjIyIFBNLCBMdWNrLCBUb255IHdyb3RlOg0KPj4gSXQgYXBwZWFycyB0
aGUga2VybmVsIGlzIHRydXN0aW5nIHRoYXQgLT5waHlzaWNhbF9hZGRyX21hc2sgaXMgbm9uLXpl
cm8NCj4+IGluIG90aGVyIHBhdGhzLiBTbyB0aGlzIGlzIGF0IGxlYXN0IGVxdWFsbHkgYnJva2Vu
IGluIHRoZSBwcmVzZW5jZSBvZiBhDQo+PiBicm9rZW4gQklPUy4gVGhlIGltcGFjdCBpcyBwb3Rl
bnRpYWxseSBsYXJnZXIgdGhvdWdoIHdpdGggdGhpcyBjaGFuZ2UsDQo+PiBzbyBpdCBtaWdodCBi
ZSBhIGdvb2QgZm9sbG93LW9uIHBhdGNoIHRvIG1ha2Ugc3VyZSB0aGF0DQo+PiAtPnBoeXNpY2Fs
X2FkZHJfbWFzayBnZXRzIGZpeGVkIHVwIHRvIGEgbWluaW11bSBtYXNrIHZhbHVlLg0KPiANCj4g
QWdyZWVkLiBTZXBhcmF0ZSBwYXRjaCB0byBzYW5pdGl6ZSBlYXJseSwgc28gb3RoZXIga2VybmVs
IGNvZGUgY2FuIGp1c3QgdXNlIGl0Lg0KPiANCg0KSXMgaXQgcG9zc2libGUgdGhhdCB3aXRoDQog
ICBpZiAobWVtLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQV9NQVNLKQ0KdGhl
IC0+cGh5c2ljYWxfYWRkcl9tYXNrIGlzIHN0aWxsIHVudHJ1c3R3b3J0aHk/DQoNCmluY2x1ZGUv
cmFzL3Jhc19ldmVudC5oIGhhcyB0aGlzDQogICAgICAgaWYgKG1lbS0+dmFsaWRhdGlvbl9iaXRz
ICYgQ1BFUl9NRU1fVkFMSURfUEFfTUFTSykNCiAgICAgICAgICAgICAgICAgICAgICAgICBfX2Vu
dHJ5LT5wYV9tYXNrX2xzYiA9IA0KKHU4KV9fZmZzNjQobWVtLT5waHlzaWNhbF9hZGRyX21hc2sp
Ow0KICAgICAgICAgICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgICAgICAgICAgX19lbnRy
eS0+cGFfbWFza19sc2IgPSB+MDsNCndoaWNoIGhpbnRzIG90aGVyd2lzZS4NCg0KYXBlaV9tY2Vf
cmVwb3J0X21lbV9lcnJvcigpIGFscmVhZHkgY2hlY2tzIG1lbS0+dmFsaWRhdGlvbl9iaXRzDQp1
cCBmcm9udC4NCg0KdGhhbmtzIQ0KLWphbmUNCg0KDQo+IC1Ub255DQoNCg==
